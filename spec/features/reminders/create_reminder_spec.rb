# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create reminder', type: :feature do
  let(:user) { create(:user) }

  describe 'permissions' do
    it 'requires user to be authenticated' do
      expect { visit_page }.to require_authentication
    end
  end

  describe 'when form submission is invalid' do
    it 'validation errors are shown' do
      login
      visit_page

      fill_in 'Name', with: ''
      fill_in 'Number of notes', with: ''

      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Name can't be blank"
      expect(page).to have_text t('validation.reminder.number_of_notes')

      fill_in 'Number of notes', with: '0'
      submit_form

      expect(page).to have_text t('validation.reminder.number_of_notes')
    end
  end

  describe 'when form is submitted with the default values' do
    it 'reminder is created' do
      login
      visit_page

      submit_form

      expect(page).to have_current_path reminders_path
      expect(page).to have_text t('notices.reminders.created')
      expect(Reminder.last).to have_attributes({
        name: Reminder::DEFAULT_NAME,
        number_of_notes: Reminder::DEFAULT_NUMBER_OF_NOTES
      })
    end
  end

  describe 'when form is submitted with custom but valid values' do
    it 'reminder is created' do
      login
      visit_page

      fill_in 'Name', with: 'My awesome reminder'
      fill_in 'Number of notes', with: '10'
      submit_form

      expect(page).to have_text t('notices.reminders.created')
      expect(Reminder.last).to have_attributes({
        name: 'My awesome reminder',
        number_of_notes: 10
      })
    end
  end

  def visit_page
    visit new_reminder_path
  end

  def submit_form
    click_on 'Create Reminder'
  end
end
