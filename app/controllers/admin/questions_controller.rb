class Admin::QuestionsController < Admin::AdminController
  before_action :logged_in_user
  before_action :check_admin_supervisor
  before_action :load_list_subject, only: %i(index new create)
  before_action :load_subject, only: :create
  before_action :load_list_question_type, only: %i(new create)

  def index
    @questions = Question.includes(:user, :subject).lastest
                         .paginate page: params[:page],
                          per_page: Settings.per_page_question
    @list_user = User.sort_by_first_name.pluck :first_name, :id
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

  private

  def question_params
    defaults = {create_by: current_user.id}
    params.require(:question).permit(Question::QUESTIONS_PARAMS)
                             .reverse_merge(defaults)
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
end
