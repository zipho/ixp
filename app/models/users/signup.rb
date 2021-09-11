# frozen_string_literal: true

module Users
  class Signup < ActiveType::Record[User]
    EMAIL = /\A[a-z0-9\+\-_\.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,
              format: { with: EMAIL, message: ' is invalid' },
              uniqueness: { case_sensitive: false },
              length: { minimum: 4, maximum: 254 }

    def self.register(authorize_params)
      create!(
        email: authorize_params.email,
        first_name: authorize_params.first_name,
        last_name: authorize_params.last_name,
        password: authorize_params.password,
        password_confirmation: authorize_params.password_confirmation
      )
    end
  end
end
