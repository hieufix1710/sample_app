class User < ApplicationRecord
  before_save :email_downcase
  validates :name, presence: true
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, uniqueness: true, format: {with:
   VALID_EMAIL_REGEX}
  has_secure_password

  def email_downcase
    email.downcase!
  end
end
