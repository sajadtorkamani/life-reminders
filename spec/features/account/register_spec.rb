# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :feature do
  describe 'when form input is invalid' do
    it 'error messages are shown' do
      visit new_user_registration_path

      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Email can't be blank"
      expect(page).to have_text "Password can't be blank"

      fill_in 'Password', with: 'password', match: :prefer_exact
      submit_form

      expect(page).to have_text "Password confirmation doesn't match Password"
    end
  end

  describe 'when form input is valid' do
    it 'user is registered' do
      attributes = attributes_for(:user, email: 'john@example.com')
      visit new_user_registration_path

      fill_in 'Email', with: attributes[:email]
      fill_in 'Password', with: attributes[:password], match: :prefer_exact
      fill_in 'Password confirmation', with: attributes[:password]
      submit_form

      expect(page).to have_content I18n.t('devise.registrations.signed_up')
      expect(page).to have_text 'john'
    end
  end

  def submit_form
    click_button 'Register'
  end
end