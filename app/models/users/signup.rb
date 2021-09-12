# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :datetime
#  email           :string
#  first_name      :string
#  gender          :bigint
#  last_name       :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
module Users
  class Signup < ActiveType::Record[User]
    validates :email, :first_name, :last_name, :password, presence: true, if: -> { birthday.blank? && gender.blank? }
    validates :birthday, :gender, presence: true, unless: -> { id.blank? }

    EMAIL = /\A[a-z0-9+\-_.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
              format: { with: EMAIL, message: ' is invalid' },
              uniqueness: { case_sensitive: false },
              length: { minimum: 4, maximum: 254 }

    PASSWORD_FORMAT = /\A
    (?=.*[A-Z]) # Must contain an uppercase character
    (?=.*[a-z]) # Must contain a lowercase character
    (?=.*\d) # Must contain a digit
    (?=.*[[:^alnum:]]) # Must contain a symbol
    /x

    validates :password, length: { minimum: 6 }
    validates :password,
              format: { with: PASSWORD_FORMAT,
                        message: ' must include: 1 uppercase, 1 lowercase, 1 digit and 1 special character' }
    validate :validate_age

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
        password_confirmation: user[:password_confirmation]
      )
    end

    def self.next(user, params)
      user.update({ gender: params[:gender], birthday: params[:birthday] })
    end

    private

    def validate_age
      if birthday.present? && birthday > 150.years.ago.to_date
        errors.add(:birthday, ' should be less than 150 years old.')
      end
    end
  end
end
