class ExamsController < ApplicationController
  before_action :logged_in_user
  before_action :load_exam, :valid_user, only: %i(show update)
  before_action :check_time_expired, only: :update

  def index
    @exams = current_user.exams.exam_lastest.includes(:subject)
                         .paginate page: params[:page],
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
        flash[:danger] = t "exam_page.failed"
        redirect_to exams_path
      end
    else
      flash[:danger] = t "exam_page.failed_question"
    end
    redirect_to exams_path
  end

  def show
    if @exam.start?
      begin
        ActiveRecord::Base.transaction do
          @exam.update! status: Exam.statuses[:doing]
          update_time_exam @exam
        end
      rescue StandardError
        flash[:danger] = t "exam_page.failed"
        redirect_to exams_path
      end
    end
    load_remainng_time @exam
    @questions = @exam.questions.includes(:answers)
    @user_answered = @exam.user_answer_exams
                          .map{|x| [x.question_id, x.answer_user]}.to_h
  end

  def update
    if detail_params.nil?
      flash[:success] = t "exam_page.exam_updated"
    else
      begin
        ActiveRecord::Base.transaction do
          update_user_answer detail_params.keys
          flash[:success] = t "exam_page.exam_updated"
          finish_exam params[:commit]
        end
      rescue StandardError
        flash[:danger] = t "exam_page.updated_failed"
        redirect_to exams_path
      end
    end
    redirect_to exams_path
  end

  private

  def exams_params
    defaults = {start_time: Time.zone.now}
    params.require(:exam).permit(:subject_id).reverse_merge(defaults)
  end

  def user_answer_params
    params.require(:exam).permit :detail_question_answer
  end

  def detail_params
    params[:exam][:detail_question_answer] if params[:exam].present?
  end

  def check_limit_question?
    subject = Subject.find_by id: params[:exam][:subject_id]
    if subject.nil?
      flash[:danger] = "exam_page.subject_fail"
      redirect_to exams_path
    else
      Question.load_by_subject(subject.id).size >= subject.limit_questions
    end
  end

  def load_exam
    @exam = Exam.includes(:questions).find_by id: params[:id]
    return if @exam
    flash[:danger] = t "exam_page.exam_not_found"
    redirect_to exams_path
  end

  def load_remainng_time exam
    @remaining_time = if exam.start? || exam.doing?
                        exam.finish_time
                      else
                        Settings.time_remaning_default
                      end
  end

  def finish_exam commit
    return unless commit == Settings.submit_finish
    @exam.update_attributes(status: Exam.statuses[:uncheck],
      finish_time: Time.zone.now)
  end

  def valid_user
    return if current_user?(@exam.user) || current_user.admin? \
      || current_user.supervisor?
    flash[:danger] = t "errors_message.access_denied"
    redirect_to exams_path
  end

  def check_time_expired
    return if Time.zone.now < @exam.finish_time
    begin
      @exam.update! status: Exam.statuses[:uncheck]
    rescue StandardError
      flash[:danger] = t "exam_page.expired_time"
      redirect_to exams_path
    end
  end

  def check_correct? question_id, answer
    question = Question.find_by id: question_id
    return unless question
    if question.single_choice?
      answer_correct = Answer.find_by id: answer.to_i
      return unless answer_correct
      answer_correct.is_correct?
    else
      array_correct_ans = question.answers.correct_answer.pluck(:id)
      answer_user = answer.map(&:to_i)
      (array_correct_ans - answer_user).blank?
    end
  end

  def update_time_exam exam
    time_finish = Time.now + exam.subject.duaration * Settings.hour_num
    @exam.update_attributes(start_time: Time.zone.now, finish_time: time_finish)
  end

  def update_user_answer list_qs_answer
    @exam.user_answer_exams.each do |question_exam|
      list_qs_answer.each do |user_qs|
        next unless question_exam.question_id == user_qs.to_i
        correct = check_correct? user_qs.to_i, detail_params[user_qs]
        question_exam.update_attributes answer_user: detail_params[user_qs],
          is_correct: correct
      end
    end
  end

  def random_question_for exam
    qs_random_ids = Question.load_by_subject(exam.subject_id).active
                            .order("rand()")
                            .limit(exam.subject.limit_questions)
    exam.questions << qs_random_ids
    exam_qs = qs_random_ids.pluck(:id)
    exam_qs.each do |qs|
      user_question = @exam.user_answer_exams.build question_id: qs
      user_question.save!
    end
  end
end
