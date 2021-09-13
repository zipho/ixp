# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "some_password" }
    password_confirmation { "some_password" }
    signup_step { 1 }
    # factory :confirmed_user, :parent => :user do
    #   after_create { |user| user.confirmed_at = Time.now }
    #   # after_build { |user| user.confirm }
    # end

    trait :step2 do
      signup_step { 2 }
      birthday { '1949/06/22' }
      gender { Faker::Gender.between(0, 1, 2) }
    end
  end
end
