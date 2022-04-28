# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Forgot password', type: :feature do
  it 'forgot password page is only accessible to guests' do
    login

    visit_page

    expect(page).to have_text t('devise.failure.already_authenticated')
  end

  describe 'when no email is given' do
    it 'error message is shown' do
      visit_page

      submit_form

      expect(page).to have_text "Email can't be blank"
    end
  end

  describe "when given an email that isn't registered" do
    it 'error message is shown' do
      visit_page

      fill_in 'Emai', with: 'blahblah@example.com'
      submit_form

      expect(page).to have_text 'Email not found'
    end
  end

  describe 'when given a email that is registered' do
    it 'reset password email is sent' do
      user = create(:user)
      visit_page

      fill_in 'Email', with: user.email
      submit_form

      expect(page).to have_text t('devise.passwords.send_instructions')
      expect(sent_emails.last.subject).to eq t('devise.mailer.reset_password_instructions.subject')
      expect(sent_emails.last.to).to eq [user.email]
    end
  end

  def visit_page
    visit new_user_password_path
  end

  def submit_form
    click_button 'Send me reset password instructions'
  end
end
