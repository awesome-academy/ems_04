module Admin::QuestionsHelper
  def url_action question
    question.new_record? ? admin_questions_path : admin_question_path
  end
end
