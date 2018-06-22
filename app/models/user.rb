class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :orders
  has_many :ratings
  has_many :comments
  has_many :suggests

  enum role: %i(member admin)

  validates :name, presence: true, length: {maximum: Settings.name_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email_max},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: Settings.pass_min}, allow_nil: true

  scope :newest, ->{order created_at: :desc}

  def self.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_token, User.digest(remember_token)
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_token).is_password?(remember_token)
  end

  def forget
    update_attribute :remember_token, nil
  end
end
