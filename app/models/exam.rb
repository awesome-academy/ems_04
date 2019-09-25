class Exam < ApplicationRecord
  belongs_to :subject
  belongs_to :user
  has_and_belongs_to_many :questions

  enum status: {start: 0, uncheck: 1, checked: 2}

  scope :exam_lastest, ->{order created_at: :desc}
end
