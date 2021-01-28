class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :email_downcase
  before_create :create_activation_digest

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: {with:
   VALID_EMAIL_REGEX}
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true
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

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end


  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end

  def send_activation_email
  UserMailer.account_activation(self).deliver_now
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end


  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute :reset_digest, User.digest(reset_token)
    update_attribute :reset_sent_at, Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end



  private
  def email_downcase
    email.downcase!
  end


  def downcase_email
    self.email.downcase!
  end

end
