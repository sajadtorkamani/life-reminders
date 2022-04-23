# frozen_string_literal: true

require 'rails_helper'

describe 'Home' do
  it 'renders homepage when user is not logged in' do
    visit root_path

    expect(page).to have_text 'Get started'
    expect(page).to have_text 'Login'
    expect(page).to have_text 'Register'
  end

  it 'redirects to notes index page when user is logged in' do
    user = create(:user)
    login_as(user)

    visit root_path

    expect(page).to have_current_path(notes_path)
    expect(page).to have_text 'Notes'
  end
end
