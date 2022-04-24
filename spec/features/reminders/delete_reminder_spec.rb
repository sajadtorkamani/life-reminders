# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete reminder', type: :feature do
  describe 'permissions' do
    it "only the reminder's owner can delete the reminder", type: :request do
      jim, bob = create_pair(:user)
      bob_reminder = create(:reminder, user: bob)

      login_as(jim)

      expect { delete reminder_path(bob_reminder) }.to raise_unauthorized_error
    end
  end

  it 'users can delete their reminders', :js do
    user = create(:user)
    create(:reminder, user:)

    login_as(user)
    visit reminders_path

    click_and_confirm 'Delete'
    expect(page).to have_text t('notices.reminders.deleted')
    expect(page).to have_current_path reminders_path
    expect(user.reminders).to be_empty
  end
end
