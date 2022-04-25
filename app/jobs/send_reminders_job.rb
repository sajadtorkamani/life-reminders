# frozen_string_literal: true

# Sends daily reminders to users who:
# - have a reminder configured
# - have at least one note
class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform
    Reminder.with_notes.each do |reminder|
      ReminderMailer.with(reminder:).reminder_email.deliver_now
    end
  end
end
