class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user, foreign_key: :create_by
  has_and_belongs_to_many :exams

  scope :find_by_subject, ->(subject_id){where subject_id: subject_id}

  enum question_type: {single_choice: 0, multi_choice: 1}
end
