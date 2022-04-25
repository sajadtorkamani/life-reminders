# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReminderMailer, type: :mailer do
  describe 'reminder_email' do
    it 'builds the correct email content' do
      reminder = create(:reminder, :with_notes)

      email = described_class.with(reminder:).reminder_email

      expect(email.from).to eq [Rails.configuration.default_sender_email]
      expect(email.to).to eq [reminder.user.email]
      expect(email.subject).to eq reminder.name

      [email.html_part.body, email.text_part.body].each do |email_body|
        reminder.notes.each do |note|
          expect(email_body).to include note.content.to_plain_text
        end
      end
    end
  end
end
