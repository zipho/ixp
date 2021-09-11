class User < ApplicationRecord
  validates :email, :first_name, :last_name, :password_digest, presence: true
  has_secure_password
end
