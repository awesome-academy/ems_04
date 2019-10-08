module Admin::QuestionsHelper
  def url_action question
    question.new_record? ? admin_questions_path : admin_question_path
  end

  def content_submit_question question
    if question.new_record?
      I18n.t("question_page.add_quesion")
    else
      I18n.t("app_button.update")
    end
  end
end
