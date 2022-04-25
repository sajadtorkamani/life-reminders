# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendRemindersJob, type: :job do
  xit 'sends a reminder email to users who have a reminder configured' do
    # user = create(:user)
    # notes = create_list(:note, 3, user:)
    # reminder = create(:reminder, user:)
    #
    # SendRemindersJob.perform_now
    #
    # emails_sent = ActionMailer::Base.deliveries
    # expect(emails_sent.count).to eq 1
  end

  # it "doesn't send a reminder email to users who have reminders configured but not notes" do
  #
  # end
end
