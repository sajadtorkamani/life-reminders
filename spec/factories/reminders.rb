# frozen_string_literal: true

FactoryBot.define do
  factory :reminder do
    user
    name { "Reminders: #{Faker::Lorem.word}" }
    number_of_notes { Reminder::DEFAULT_NUMBER_OF_NOTES }

    trait :with_notes do
      after(:build) do |reminder|
        create_list(:note, 3, user: reminder.user)
      end
    end

    trait :without_notes do
      after(:build) do |reminder|
        reminder.user.notes.destroy_all if reminder.user.notes.any?
      end
    end
  end
end
