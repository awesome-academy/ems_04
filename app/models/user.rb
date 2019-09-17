class User < ApplicationRecord
  attr_accessor :remember_token

  has_many :exams, dependent: :destroy
  has_many :subjects, dependent: :destroy

  enum role: {trainee: 0, supervisor: 1, admin: 2}

  before_save :downcase_email

  has_secure_password

  # Decrypt a string
  def self.digest string
    if ActiveModel::SecurePassword.min_cost
      BCrypt::Password.create(string, cost: BCrypt::Engine::MIN_COST)
    else
      BCrypt::Password.create(string, cost: BCrypt::Engine.cost)
    end
  end

  # Return a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # compare remember_token vs remember_digest
  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end

  # save remember_token to database
  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  # forget remmeber token
  def forget
    update_attribute :remember_digest, nil
  end

  def full_name
    "#{last_name} #{first_name}"
  end

  private

  def downcase_email
    self.email = email.downcase
  end
end
