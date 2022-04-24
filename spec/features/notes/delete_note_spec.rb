# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete note', type: :feature do
  it "a user cannot delete another user's note", type: :request do
    jim, bob = create_pair(:user)
    bob_note = create(:note, user: bob)

    login_as(jim)

    expect { delete note_path(bob_note) }.to raise_unauthorized_error
  end

  it 'users can delete their notes', :js do
    user = create(:user)
    create(:note, user:)

    login_as(user)
    visit notes_path

    click_and_confirm 'Delete'
    expect(page).to have_text I18n.t('notices.notes.deleted')
  end
end
