# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'factories' do
    it 'has a valid default factory' do
      expect(build(:reminder)).to be_valid
    end

    it ':with_notes returns a reminder with 3 notes' do
      expect(build(:reminder, :with_notes).notes.length).to eq 3
    end

    it ':without_notes returns a reminder with 0 notes' do
      expect(build(:reminder, :without_notes).notes.length).to eq 0
    end
  end

  describe 'default attribute values' do
    it "sets :name to 'Default reminder' by default" do
      reminder = described_class.new
      expect(reminder.name).to eq 'Default reminder'
    end

    it 'sets :number_of_notes to 3 by default' do
      reminder = described_class.new
      expect(reminder.number_of_notes).to eq 3
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    subject { build(:reminder) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }

    it 'validates that :number_of_notes is between 1 and 10' do
      reminder = build(:reminder, number_of_notes: 0)

      expect(reminder).to be_invalid
      expect(reminder.errors[:number_of_notes])
        .to eq ['must be a number between 1 and 10']
    end
  end

  describe '.notes' do
    it 'returns x number of notes, where x is the :number_of_notes attribute' do
      user = create(:user)
      create_list(:note, 4, user:)
      reminder = create(:reminder, number_of_notes: 2, user:)

      expect(reminder.notes.count).to eq 2
    end

    it 'returns no notes if the user has no notes' do
      user = create(:user)
      reminder = create(:reminder, number_of_notes: 3, user:)

      expect(reminder.notes.count).to eq 0
    end
  end

  describe 'scopes' do
    describe '.with_notes' do
      it 'returns only reminders where the associated user has at least one note' do
        reminder_1_with_notes = create(:reminder, :with_notes)
        reminder_2_with_notes = create(:reminder, :with_notes)
        _reminder_3_without_notes = create(:reminder, :without_notes)

        expect(described_class.with_notes).to eq [
          reminder_1_with_notes,
          reminder_2_with_notes
        ]
      end
    end
  end
end
