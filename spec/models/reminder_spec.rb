# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reminder, type: :model do
  describe 'factories' do
    it 'has a valid default factory' do
      expect(build(:reminder)).to be_valid
    end
  end

  it 'sets :number_of_notes to 3 by default' do
    reminder = described_class.new
    expect(reminder.number_of_notes).to eq 3
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:number_of_notes) }
    it { is_expected.to validate_numericality_of(:number_of_notes).only_integer }
    it { is_expected.to validate_numericality_of(:number_of_notes).is_greater_than_or_equal_to(1) }
    it { is_expected.to validate_numericality_of(:number_of_notes).is_less_than_or_equal_to(10) }
  end
end
