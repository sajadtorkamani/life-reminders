# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reset password', type: :feature do
  it 'reset password page is only accessible to guests' do
    login

    visit_page

    expect(page).to have_text t('devise.failure.already_authenticated')
  end

  xdescribe 'when form submission is invalid' do
    it 'validation errors are shown' do
      visit_page

      submit_form

      expect(page).to have_text "New password can't be blank"
    end
  end

  def visit_page
    visit edit_user_password_path
  end

  def submit_form
    click_button 'Change my password'
  end
end
