class Subject < ApplicationRecord
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  belongs_to :user, foreign_key: :create_by
end
