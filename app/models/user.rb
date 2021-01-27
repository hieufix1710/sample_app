class User < ApplicationRecord
  attr_accessor :remember_token
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: {with:
   VALID_EMAIL_REGEX}
  before_save :email_downcase
  has_secure_password

  def forget
    update_attribute :remember_digest, nil
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def self.digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create string, cost: cost
  end
  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  private
  def email_downcase
    email.downcase!
  end
end
