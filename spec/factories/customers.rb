# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Internet.user_name }
    rating { Faker::Number.number(digits: 1) }
    is_recommended { Faker::Boolean.boolean }
    footer_text { Faker::Lorem.paragraph }
    website { Faker::Internet.url }
  end
end
