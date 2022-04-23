# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  describe 'when credentials are invalid' do
    it 'error message is shown' do
      visit new_user_session_path

      submit_form

      expect(page).to have_text invalid_credentials_message
    end
  end

  describe 'when credentials are valid' do
    it 'user is logged in' do
      user = create(:user)
      visit new_user_session_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      submit_form

      expect(page).to have_text login_success_message
      expect(page).to have_text user.truncated_email
      expect(page).to have_current_path root_path
    end
  end

  def submit_form
    click_button 'Log in'
  end

  def invalid_credentials_message
    I18n.t('devise.failure.invalid')
  end

  def login_success_message
    I18n.t('devise.sessions.signed_in')
  end
end
