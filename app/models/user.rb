class User < ApplicationRecord
  before_save :downcase_email
  has_secure_password

  private

  def downcase_email
    self.email.downcase!
  end
end
