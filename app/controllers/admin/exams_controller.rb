class Admin::ExamsController < Admin::AdminController
  before_action :logged_in_user
  before_action :check_admin_supervisor
  before_action :load_exam, only: :update

  def index
    @exams = Exam.includes(:subject).exam_lastest.paginate(page: params[:page],
      per_page: Settings.per_page_exam)
  end

  def update
    total_score = sum_exam_scorelist_question @exam.user_answer_exams.is_correct
    exam_passed total_score, @exam.subject.total_score
    if @exam.update_attributes(exam_score: total_score,
      status: Exam.statuses[:checked])
      respond_result @exam, total_score.size
    else
      flash[:danger] = t "exam_page.failed"
      redirect_to exams_path
    end
  end

  private

  def load_exam
    @exam = Exam.find_by id: params[:id]
    return if @exam
    flash[:danger] = t "exam_page.failed"
    redirect_to exams_path
  end

  def sum_exam_scorelist_question array_correct
    array_correct.reduce(0){|a, e| a + e.question.score}
  end

  def exam_passed score_exam, score_pass
    @exam.update_attribute(:is_passed, true) if score_exam > score_pass
  end

  def respond_result exam, total_correct
    result = {exam_id: exam.id,
              total_qs: exam.subject.limit_questions,
              total_correct: total_correct.size,
              passed: exam.is_passed,
              total_score: exam.exam_score}
    respond_to do |format|
      format.json{render json: result}
    end
  end
end
