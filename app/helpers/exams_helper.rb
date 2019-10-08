module ExamsHelper
  def list_subject
    Subject.sort_by_name.active.map{|p| [p.subject_name, p.id]}
  end

  def spent_time exam
    if exam.finish_time
      time = exam.finish_time - exam.start_time
      Time.at(time).utc.strftime(Settings.time_spent_format)
    else
      Settings.default_time
    end
  end

  def is_checked? user_answered, question, answer
    user_answered[question.id]&.include?(answer.id.to_s)
  end

  def disable_button? exam
    exam.uncheck? || exam.checked?
  end

  def total_question_correct exam
    exam.user_answer_exams.is_correct.size
  end

  def is_admin_supervisor?
    current_user.admin? || current_user.supervisor?
  end

  def hightlight_correct answer
    if answer.is_correct? && is_admin_supervisor?
      "text-green"
    else
      "fa-class"
    end
  end
end
