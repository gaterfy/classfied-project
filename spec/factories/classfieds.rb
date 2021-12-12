# frozen_string_literal: true

FactoryBot.define do
  factory :classfied do
    title { Faker::Lorem.sentence }
    price { Faker::Number.number(33) }
    description { Faker::Lorem.paragraph }
  end
end
