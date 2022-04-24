# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reminders index page', type: :feature do
  it 'requires user to be authenticated' do
    expect { visit_page }.to require_authentication
  end

  describe 'when user has no reminders' do
    it 'shows empty reminders message and a link to create a reminder' do
      login

      visit_page

      expect(page).to have_text 'You have no reminders.'
      expect(page).to have_text 'Create your first reminder'
    end
  end

  def visit_page
    visit reminders_path
  end
end
