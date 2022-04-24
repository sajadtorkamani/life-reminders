# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/reminder
class ReminderMailerPreview < ApplicationMailerPreview
  def reminder_email
    user = create(:user)
    create_list(:note, 3, user:)
    reminder = create(:reminder, user:)

    ReminderMailer.with(reminder:).reminder_email
  end
end
