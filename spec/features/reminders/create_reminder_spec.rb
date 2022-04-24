# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create reminder', type: :feature do
  let(:user) { create(:user) }

  it 'requires user to be authenticated' do
    expect { visit_page }.to require_authentication
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
      expect(page).to have_text 'Number of notes must be a number between 1 and 10'

      fill_in 'Number of notes', with: '0'
      submit_form

      expect(page).to have_text 'Number of notes must be a number between 1 and 10'
    end
  end

  describe "when the default form values aren't changed" do
    it 'reminder is created' do
      login
      visit_page

      submit_form

      expect(page).to have_current_path reminders_path
      expect(page).to have_text I18n.t('notices.reminders.created')
      expect(Reminder.last.attributes.with_indifferent_access).to match(
        hash_including({
          name: Reminder::DEFAULT_NAME,
          number_of_notes: Reminder::DEFAULT_NUMBER_OF_NOTES
        })
      )
    end
  end

  describe 'when form values are changed but valid' do
    it 'reminder is created' do
      login
      visit_page

      fill_in 'Name', with: 'My awesome reminder'
      fill_in 'Number of notes', with: '10'
      submit_form

      expect(page).to have_text I18n.t('notices.reminders.created')
      expect(Reminder.last.attributes.with_indifferent_access).to match(
        hash_including({
          name: 'My awesome reminder',
          number_of_notes: 10
        })
      )
    end
  end

  def visit_page
    visit new_reminder_path
  end

  def submit_form
    click_on 'Create Reminder'
  end
end
