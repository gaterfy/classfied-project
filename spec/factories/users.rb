# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Internet.user_name }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }

    password_digest { Faker::Internet.password }
  end
end
