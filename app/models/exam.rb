class Exam < ApplicationRecord
  has_and_belongs_to_many :questions
  has_many :user_answer_exams
  belongs_to :subject
  belongs_to :user
  has_and_belongs_to_many :questions

  enum status: {start: 0, doing: 1, uncheck: 2, checked: 3}

  scope :exam_lastest, ->{order created_at: :desc}
end
