# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotePolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { create(:user) }
  let(:reminder) { create(:reminder) }

  permissions :edit?, :update? do
    it 'denies permission if user is not the owner of the note' do
      expect(policy).not_to permit(user, reminder)
    end

    it 'grants permission if user is the owner of the note' do
      note = create(:reminder, user:)
      expect(policy).to permit(user, note)
    end
  end

  permissions :destroy? do
    it 'denies permission if user is not the owner of the note' do
      expect(policy).not_to permit(user, reminder)
    end

    it 'grants permission if user is the owner of the note' do
      note = create(:reminder, user:)
      expect(policy).to permit(user, note)
    end
  end
end
