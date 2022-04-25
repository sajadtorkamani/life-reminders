# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendRemindersJob, type: :job do
  it 'sends a reminder email to users who have a reminder configured' do
    jim = create(:user)
    jim_reminder = create(:reminder, :with_notes, user: jim)
    _bob = create(:user)

    described_class.perform_now

    emails_sent = ActionMailer::Base.deliveries
    expect(emails_sent.count).to eq 1
    expect(emails_sent.map(&:to).flatten).to eq [jim.email]
    expect(emails_sent.map(&:subject)).to eq [jim_reminder.name]
  end

  it "doesn't send a reminder email to users who have reminders configured but have no notes" do
    jim = create(:user)
    jim_reminder = create(:reminder, :with_notes, user: jim)
    bob = create(:user)
    _bob_reminder = create(:reminder, :without_notes, user: bob)

    described_class.perform_now

    emails_sent = ActionMailer::Base.deliveries
    expect(emails_sent.map(&:to).flatten).to eq [jim.email]
    expect(emails_sent.map(&:subject)).to eq [jim_reminder.name]
  end
end
