class Question < ApplicationRecord
  QUESTIONS_PARAMS = [:question_content, :score, :question_type,
    :create_by, :subject_id, answers_attributes: [:id, :answer_content,
      :is_correct, :_destroy]].freeze

  has_many :answers, dependent: :destroy
  belongs_to :user, foreign_key: :create_by
  belongs_to :subject
  has_and_belongs_to_many :exams

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :question_content, presence: true

  delegate :subject_name, to: :subject

  scope :load_by_subject, ->(subject_id){where subject_id: subject_id}
  scope :lastest, ->{order created_at: :desc}
  scope :search_by_content, lambda {|qs_content|
    where "question_content LIKE (?)", "%#{qs_content}%"
  }
  scope :search_by_date, ->(date){where created_at: date}
  scope :search_by_user, ->(user_id){where create_by: user_id}

  enum question_type: {single_choice: 0, multi_choice: 1}
  enum is_deleted: {active: 0, deleted: 1}

  def deleted
    update_attributes is_deleted: Settings.question_deleted,
      deleted_at: Time.zone.now
  end
end
