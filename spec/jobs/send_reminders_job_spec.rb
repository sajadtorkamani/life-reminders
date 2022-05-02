# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendRemindersJob, type: :job do
  it 'sends a reminder email to users who have a reminder configured' do
    user_with_reminder = create(:user)
    create(:reminder, :with_notes, user: user_with_reminder)
    _user_without_reminder = create(:user)

    described_class.perform_now

    expect(sent_emails.count).to eq 1
    expect(sent_emails.map(&:to).flatten).to eq [user_with_reminder.email]
    expect(sent_emails.map(&:subject)).to eq [user_with_reminder.reminders.first.name]
  end

  it "doesn't send a reminder email to users who have a reminder configured but have no notes" do
    jim = create(:user)
    jim_reminder = create(:reminder, :with_notes, user: jim)
    bob = create(:user)
    _bob_reminder = create(:reminder, :without_notes, user: bob)

    described_class.perform_now

    expect(sent_emails.map(&:to).flatten).to eq [jim.email]
    expect(sent_emails.map(&:subject)).to eq [jim_reminder.name]
  end
end
