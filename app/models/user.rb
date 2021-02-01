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
   has_many :microposts, dependent: :destroy
   has_many :active_relationships, class_name: Relationship.name,
   foreign_key: :follower_id, dependent: :destroy
   has_many :passive_relationships, class_name: Relationship.name,
   foreign_key: :followed_id, dependent: :destroy
   has_many :following, through: :active_relationships, source: :followed
   has_many :followers, through: :passive_relationships, source: :follower

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

def feed
  Micropost.where("user_id IN (?) OR user_id = ?", following_ids, id)
end


def follow other_user # Follows a user.
  following << other_user
end
def unfollow other_user # Unfollows a user.
  following.delete other_user
end
def following? other_user # Returns if the current user is following the other_user or not
  following.include? other_user
end



private
def email_downcase
  email.downcase!
end


def downcase_email
  self.email.downcase!
end

end
