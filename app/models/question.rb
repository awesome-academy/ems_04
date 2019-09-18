class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :user, foreign_key: :create_by
end
