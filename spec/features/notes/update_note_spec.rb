# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update note', type: :feature do
  let(:user) { create(:user) }
  let(:note) { create(:note, user:) }

  describe 'permissions' do
    it 'edit page requires user to be authenticated' do
      expect { visit edit_note_path(note) }.to require_authentication
    end
  end

  describe 'when form submission is invalid' do
    it 'validation errors are shown', :js do
      login_as(user)
      visit edit_note_path(note)

      fill_in_trix_editor 'note_content', with: ' '
      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Content can't be blank"
    end
  end

  describe 'when form submission is valid' do
    it 'note is updated', :js do
      login_as(user)
      visit edit_note_path(note)

      fill_in_trix_editor 'note_content', with: 'My new note'
      submit_form

      expect(page).to have_current_path notes_path
      expect(page).to have_text t('notices.notes.updated')
      expect(page).to have_text 'My new note'
    end
  end

  def submit_form
    click_on 'Update Note'
  end
end
