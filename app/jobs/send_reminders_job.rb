# frozen_string_literal: true

class SendRemindersJob < ApplicationJob
  queue_as :default

  def perform
    # reminders = Reminder.all

    # reminders.each do |reminder|
    #   user = reminder.user
    #   num_of_notes = reminder.number_of_notes
    # end
    # Do something later
  end
end
