# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete note', type: :feature do
  it "a user cannot delete another user's note", type: :request do
    jim, bob = create_pair(:user)
    bob_note = create(:note, user: bob)

    login_as(jim)

    expect { delete note_path(bob_note) }.to raise_unauthorized_error
  end
end
