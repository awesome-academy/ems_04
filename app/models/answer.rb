class Answer < ApplicationRecord
  belongs_to :question

  scope :correct_answer, ->{where is_correct: true}
end
