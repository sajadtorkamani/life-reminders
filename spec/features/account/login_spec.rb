# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Login', type: :feature do
  it 'login page is only accessible to guests' do
    login

    visit_page

    expect(page).to have_text I18n.t('devise.failure.already_authenticated')
  end

  describe 'when invalid credentials are submitted' do
    it 'error message is shown' do
      visit_page

      submit_form

      expect(page).to have_text invalid_credentials_message
    end
  end

  describe 'when valid credentials are submitted' do
    it 'user is logged in' do
      user = create(:user)
      visit_page

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      submit_form

      expect(page).to have_text login_success_message
      expect(page).to have_text user.truncated_email
      expect(page).to have_current_path notes_path
    end
  end

  def visit_page
    visit new_user_session_path
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
