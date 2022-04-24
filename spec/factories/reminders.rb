# frozen_string_literal: true

FactoryBot.define do
  factory :reminder do
    user
    number_of_notes { Reminder::DEFAULT_NUMBER_OF_NOTES }
  end
end
