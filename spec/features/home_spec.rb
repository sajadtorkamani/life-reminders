# frozen_string_literal: true

require 'rails_helper'

describe 'Home' do
  describe 'when user is not logged in' do
    it 'renders the home page' do
      visit root_path

      expect(page).to have_text 'Get started'
      expect(page).to have_text 'Login'
      expect(page).to have_text 'Register'
    end
  end

  describe 'when user is logged in' do
    it 'redirects to the notes index page' do
      user = create(:user)
      login_as(user)

      visit root_path

      expect(page).to have_current_path(notes_path)
      expect(page).to have_text 'Notes'
    end
  end
end
