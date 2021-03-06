# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create note', type: :feature do
  let(:user) { create(:user) }

  describe 'permissions' do
    it 'requires user to be authenticated' do
      expect { visit new_note_path }.to require_authentication
    end
  end

  describe 'when form submission is invalid' do
    it 'validation errors are shown' do
      login
      visit new_note_path

      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Content can't be blank"
    end
  end

  describe 'when form submission is valid' do
    it 'note is created', :js do
      login
      visit new_note_path

      fill_in_trix_editor 'note_content', with: 'We all die.'
      submit_form

      expect(page).to have_current_path notes_path
      expect(page).to have_text t('notices.notes.created')
      expect(Note.last.content.to_plain_text).to eq 'We all die.'
    end
  end

  def submit_form
    click_on 'Create Note'
  end
end
