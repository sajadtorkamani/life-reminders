# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes index page', type: :feature do
  describe 'permissions' do
    it 'requires user to be authenticated' do
      expect { visit_page }.to require_authentication
    end
  end

  describe 'when user has no notes' do
    it 'shows empty notes message and a link to create a note' do
      login

      visit_page

      expect(page).to have_text 'You have no notes.'
      expect(page).to have_text 'Create your first note'
    end
  end

  describe 'when user has notes' do
    it 'lists the notes, with the most recently created appearing first' do
      user = create(:user)
      old_note = create(:note, created_at: 2.minutes.ago, user:)
      new_note = create(:note, created_at: 1.minute.ago, user:)

      login_as(user)
      visit_page

      expect(new_note.content.to_plain_text)
        .to appear_before(old_note.content.to_plain_text)
    end
  end

  def visit_page
    visit notes_path
  end
end
