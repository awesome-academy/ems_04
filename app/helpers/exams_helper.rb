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
end
