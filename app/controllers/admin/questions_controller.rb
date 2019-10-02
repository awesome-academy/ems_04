class Admin::QuestionsController < Admin::AdminController
  before_action :logged_in_user
  before_action :check_admin_supervisor
  before_action :load_list_subject, only: :index

  def index
    @questions = Question.includes(:user, :subject).lastest
                         .paginate page: params[:page],
                            per_page: Settings.per_page_question
    @list_user = User.sort_by_first_name.pluck(:first_name, :id)
  end

  def load_list_subject
    @list_subject = Subject.sort_by_name.active.pluck(:subject_name, :id)
  end
end
