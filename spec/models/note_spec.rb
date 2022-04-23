# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'factories' do
    it 'has a valid default factory' do
      expect(build(:note)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    # TODO: find a way to validate length of content
  end
end
