# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  def reminder_email
    @reminder = params[:reminder]
    @user = @reminder.user
    @notes = @reminder.notes

    mail(to: @reminder.user.email, subject: @reminder.name)
  end
end
