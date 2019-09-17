class User < ApplicationRecord
  has_many :exams, dependent: :destroy
  has_many :subjects, dependent: :destroy
end
