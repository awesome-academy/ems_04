class Answer < ApplicationRecord
  belongs_to :question

  validates :answer_content, presence: true

  scope :correct_answer, ->{where is_correct: true}
end
