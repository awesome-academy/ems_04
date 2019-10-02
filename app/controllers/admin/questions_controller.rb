class Admin::QuestionsController < Admin::AdminController
  before_action :logged_in_user
  before_action :check_admin_supervisor
  before_action :load_list_subject, except: %i(update destroy)
  before_action :load_subject, only: :create
  before_action :load_list_question_type, only: %i(new create edit)
  before_action :load_question, only: %i(edit update destroy)
  before_action :load_list_user, only: %i(index search_question)

  def index
    @questions = Question.includes(:user, :subject).active.lastest
                         .paginate page: params[:page],
                          per_page: Settings.per_page_question
  end

  def new
    @question = Question.new
    @question.answers.build
  end

  def create
    @question = @subject.questions.build question_params
    if @question.save
      flash[:success] = t "question_page.create_qs_success"
      redirect_to admin_questions_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "question_page.update_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = "question_page.update_failed"
      redirect_to admin_questions_path
    end
  end

  def destroy
    if @question.deleted
      flash[:success] = t "question_page.delete_success"
    else
      flash[:danger] = t "question_page.delete_failed"
    end
    redirect_to admin_questions_path
  end

  def search_question
    @questions = Question.includes(:subject, :user)
                         .search_by_content(params[:question_content])
                         .load_by_subject(params[:subject_id])
                         .search_by_user(params[:create_by])
                         .paginate(page: params[:page],
                          per_page: Settings.per_page_question)
    render :index
  end

  private

  def question_params
    defaults = {create_by: current_user.id}
    params.require(:question).permit(Question::QUESTIONS_PARAMS)
                             .reverse_merge(defaults)
  end

  def load_question
    @question = Question.find_by id: params[:id]
    return if @question
    flash[:danger] = "question_page.question_not_found"
    redirect_to admin_questions_path
  end

  def load_subject
    @subject = Subject.find_by id: params[:question][:subject_id]
    return if @subject
    flash[:danger] = t "exam_page.subject_fail"
    redirect_to admin_questions_path
  end

  def load_list_subject
    @list_subject = Subject.sort_by_name.active.pluck :subject_name, :id
  end

  def load_list_question_type
    @qs_type_list = Question.question_types.map{|key, val| [key.humanize, key]}
  end

  def load_list_user
    @list_user = User.sort_by_first_name.pluck :first_name, :id
  end
end
