# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update reminder', type: :feature do
  let(:user) { create(:user) }
  let(:user_reminder) { create(:reminder, user:) }
  let(:reminder) { create(:reminder) }

  describe 'permissions' do
    let(:jim) { create(:user) }
    let(:bob) { create(:user) }
    let(:bob_reminder) { create(:reminder, user: bob) }

    it 'edit page requires user to be authenticated' do
      expect { visit edit_reminder_path(reminder) }.to require_authentication
    end

    it 'edit page can only be accessed by the resource owner' do
      login_as(jim)

      expect { visit edit_reminder_path(bob_reminder) }.to raise_unauthorized_error
    end

    it "only the resource's owner can update the reminder", type: :request do
      login_as(jim)

      expect { put reminder_path(bob_reminder) }.to raise_unauthorized_error
    end
  end

  describe 'when form submission is invalid' do
    it 'validation errors are shown' do
      login_as(user)
      visit edit_reminder_path(user_reminder)

      fill_in 'Name', with: ''
      fill_in 'Number of notes', with: ''
      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Name can't be blank"
      expect(page).to have_text t('validation.reminder.number_of_notes')
    end
  end

  describe 'when form submission is valid' do
    it 'reminder is updated' do
      login_as(user)
      visit edit_reminder_path(user_reminder)

      fill_in 'Name', with: 'New name'
      fill_in 'Number of notes', with: '5'

      submit_form

      expect(page).to have_text t('notices.reminders.updated')
      expect(page).to have_current_path reminders_path
      expect(user_reminder.reload).to have_attributes({
        name: 'New name',
        number_of_notes: 5
      })
    end
  end

  def submit_form
    click_on 'Update Reminder'
  end
end
