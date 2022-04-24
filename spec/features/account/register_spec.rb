# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :feature do
  it 'register page is only accessible to guests' do
    login

    visit_page

    expect(page).to have_text t('devise.failure.already_authenticated')
  end

  describe 'when form submission is invalid' do
    it 'validation errors are shown' do
      visit_page

      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Email can't be blank"
      expect(page).to have_text "Password can't be blank"

      fill_in 'Password', with: 'password', match: :prefer_exact
      submit_form

      expect(page).to have_text "Password confirmation doesn't match Password"
    end
  end

  describe 'when form submission is valid' do
    it 'user is registered' do
      attributes = attributes_for(:user, email: 'john@example.com')
      visit_page

      fill_in 'Email', with: attributes[:email]
      fill_in 'Password', with: attributes[:password], match: :prefer_exact
      fill_in 'Password confirmation', with: attributes[:password]
      submit_form

      expect(page).to have_content t('devise.registrations.signed_up')
      expect(page).to have_text 'john'
    end
  end

  def visit_page
    visit new_user_registration_path
  end

  def submit_form
    click_button 'Register'
  end
end
