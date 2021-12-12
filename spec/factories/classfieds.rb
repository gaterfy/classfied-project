# frozen_string_literal: true

FactoryBot.define do
  factory :classfied do
    title { Faker::Lorem.sentence }
    price { Faker::Number.number(digits: 3) }
    description { Faker::Lorem.paragraph }
    user
  end
end
