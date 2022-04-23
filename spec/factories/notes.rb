# frozen_string_literal: true

FactoryBot.define do
  factory :note do
    content { Faker::Lorem.sentence }
    user
  end
end
