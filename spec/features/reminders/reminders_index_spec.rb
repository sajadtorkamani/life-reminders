# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reminders index page', type: :feature do
  describe 'permissions' do
    it 'requires user to be authenticated' do
      expect { visit_page }.to require_authentication
    end
  end

  describe 'when user has no reminders' do
    it 'shows empty reminders message and a link to create a reminder' do
      login

      visit_page

      expect(page).to have_text 'You have no reminders.'
      expect(page).to have_text 'Create your first reminder'
    end
  end

  describe 'when user has reminders' do
    let(:user) { create(:user) }

    it 'lists the reminders, with the most recently created at the top' do
      user = create(:user)
      newest_reminder = create(:reminder, created_at: 1.minute.ago, user:, name: 'Newest reminder')
      older_reminder = create(:reminder, created_at: 2.minutes.ago, user:, name: 'Older reminder')
      oldest_reminder = create(:reminder, created_at: 3.minutes.ago, user:, name: 'Oldest reminder')

      login_as(user)
      visit_page

      expect(newest_reminder.name).to appear_before(older_reminder.name)
      expect(older_reminder.name).to appear_before(oldest_reminder.name)
    end
  end

  def visit_page
    visit reminders_path
  end
end
