# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "sajadtorkamani1+#{Faker::Internet.user_name}@gmail.com" }
    password { 'password' }
  end
end
