class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user
  before_action :check_admin, except: :show
  before_action :load_subject, except: %i(index create new)

  def index
    @subjects = current_user.subjects.active.lastest
                            .paginate(page: params[:page],
                              per_page: Settings.page_subject)
    @subject = Subject.new
  end

  def create
    @subject = current_user.subjects.build subject_params
    if @subject.save
      flash[:success] = t "subject.success_create"
      redirect_to admin_subjects_path
    else
      respond_to do |format|
        format.html{render :index}
        format.js
      end
    end
  end

  def edit; end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "subject.success_update"
      redirect_to admin_subjects_path
    else
      respond_to do |format|
        format.html{render :index}
        format.js
      end
    end
  end

  def destroy
    if @subject.deleted
      flash[:success] = t "subject.delete_success"
    else
      flash[:danger] = t "subject.delete_failed"
    end
    redirect_to admin_subjects_path
  end

  private

  def subject_params
    params.require(:subject).permit :subject_name, :duaration,
      :total_score, :limit_questions
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
    return if @subject
    flash[:danger] = t "subject.delete_failed"
    redirect_to admin_subjects_path
  end
end
