# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create note', type: :feature do
  let(:user) { create(:user) }

  it 'requires user to be authenticated' do
    expect(new_note_path).to require_authentication
  end

  describe 'when form input is invalid' do
    it 'validation errors are shown' do
      login
      visit new_note_path

      submit_form

      expect(page).to have_text default_form_error_message
      expect(page).to have_text "Content can't be blank"
    end
  end

  describe 'when form input is valid' do
    it 'note is created', :js do
      login
      visit new_note_path

      find('trix-editor').click.set('We all die.')
      submit_form

      expect(page).to have_current_path root_path
      expect(page).to have_text I18n.t('notices.notes.created')
    end
  end

  def submit_form
    click_on 'Create Note'
  end
end
