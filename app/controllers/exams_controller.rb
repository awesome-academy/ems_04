class ExamsController < ApplicationController
  before_action :logged_in_user

  def index
    @exams = current_user.exams.exam_lastest.paginate page: params[:page],
      per_page: Settings.per_page_exam
    @exam = Exam.new
  end

  def create
    if check_limit_question?
      begin
        ActiveRecord::Base.transaction do
          @exam = current_user.exams.build exams_params
          if @exam.save
            random_question_for @exam
            flash[:success] = t "exam_page.success"
          end
        end
      rescue StandardError
        flash[:danger] = t("exam_page.failed")
        redirect_to exams_path
      end
    else
      flash[:danger] = t "exam_page.failed_question"
    end
    redirect_to exams_path
  end

  private

  def exams_params
    defaults = {start_time: Time.zone.now}
    params.require(:exam).permit(:subject_id).reverse_merge(defaults)
  end

  def check_limit_question?
    subject = Subject.find_by id: params[:exam][:subject_id]
    if subject.nil?
      flash[:danger] = "exam_page.subject_fail"
      redirect_to exams_path
    else
      Question.find_by_subject(subject.id).size >= subject.limit_questions
    end
  end

  def random_question_for exam
    qs_random_ids = Question.find_by_subject(exam.subject_id)
                            .order("rand()")
                            .limit(exam.subject.limit_questions)
    exam.questions << qs_random_ids
  end
end
