# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'factories' do
    it 'has a valid default factory' do
      expect(build(:reminder)).to be_valid
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
end
