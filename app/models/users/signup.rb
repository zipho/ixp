# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  birthday        :datetime
#  email           :string           not null
#  first_name      :string           not null
#  gender          :bigint
#  last_name       :string           not null
#  password_digest :string
#  signup_step     :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
module Users
  class Signup < ActiveType::Record[User]
    EMAIL = /\A[a-z0-9+\-_.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
      format: { with: EMAIL, message: " is invalid"},
      uniqueness: { case_sensitive: false },
      length: { minimum: 4, maximum: 254 }

    PASSWORD_FORMAT = /\A
    (?=.*[A-Z]) # Must contain an uppercase character
    (?=.*[a-z]) # Must contain a lowercase character
    (?=.*\d) # Must contain a digit
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    validates :password, length: {minimum: 6}
    validates :password,
      format: {with: PASSWORD_FORMAT,
               message: " must include: 1 uppercase, 1 lowercase, 1 digit and 1 special character"}

    has_secure_password

    enum gender: {
      male: 0,
      female: 1,
      non_binary: 2
    }, _prefix: true

    def self.start(user)
      create(
        email: user[:email],
        first_name: user[:first_name],
        last_name: user[:last_name],
        password: user[:password],
        password_confirmation: user[:password_confirmation],
        signup_step: user[:signup_step]
      )
    end

    def self.next(user, params)
      user.update({gender: params[:gender], birthday: params[:birthday], signup_step: params[:signup_step]})
      user
    end
  end
end
