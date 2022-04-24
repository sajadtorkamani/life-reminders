# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete note', type: :feature do
  describe 'permissions' do
    it "only the notes's owner can delete the note", type: :request do
      jim, bob = create_pair(:user)
      bob_note = create(:note, user: bob)

      login_as(jim)

      expect { delete note_path(bob_note) }.to raise_unauthorized_error
    end
  end

  it 'users can delete their notes', :js do
    user = create(:user)
    create(:note, user:)

    login_as(user)
    visit notes_path
    click_and_confirm 'Delete'

    expect(page).to have_text t('notices.notes.deleted')
    expect(page).to have_current_path notes_path
    expect(user.notes).to be_empty
  end
end
