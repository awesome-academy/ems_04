class Subject < ApplicationRecord
  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  belongs_to :user, class_name: User.name, foreign_key: :create_by

  validates :subject_name, presence: true,
            length: {maximum: Settings.max_subject_name}
  validates :duaration, :total_score, :limit_questions, presence: true

  scope :lastest, ->{order created_at: :desc}
end
