# frozen_string_literal: true

class ReminderMailer < ApplicationMailer
  def reminder_email
    @reminder = params[:reminder]
    @user = @reminder.user
    @notes = @user.notes

    mail(to: @reminder.user.email, subject: @reminder.name)
  end
end
