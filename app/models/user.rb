# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :datetime
#  email           :string           not null
#  first_name      :string           not null
#  gender          :bigint
#  last_name       :string           not null
#  password_digest :string           not null
#  signup_step     :integer          default(0), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  validates :email, :first_name, :last_name, :password, presence: true, if: -> { signup_step == 1 }
  validates :birthday, :gender, presence: true, unless: -> { signup_step == 1 }
  validates :birthday, date_time: true, unless: -> { signup_step == 1 }
  validate :validate_age, unless: -> { signup_step == 1 }

  private

  def validate_age
    if birthday.present? && birthday < 150.years.ago.to_date
      errors.add(:birthday, " should be less than 150 years old.")
    elsif birthday.present? && birthday > DateTime.now
      errors.add(:birthday, " should not be in the future.")
    end
  end
end
