class UserAnswerExam < ApplicationRecord
  belongs_to :exam
  belongs_to :question

  scope :is_correct, ->{where is_correct: true}
end
