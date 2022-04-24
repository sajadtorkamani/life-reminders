# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'factories' do
    it 'has a valid default factory' do
      expect(build(:user)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:notes).dependent(:destroy) }
    it { is_expected.to have_one(:reminder).dependent(:destroy) }
  end

  describe 'validations' do
    # Email
    it { is_expected.to validate_presence_of(:email) }

    it 'is expected to validate that :email is a valid email format' do
      user = build(:user, email: 'john@')

      expect(user).not_to be_valid
      expect(user.errors[:email]).to include 'is invalid'
    end

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

    # Password
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }
  end

  describe '#truncated_email' do
    it 'returns the first portion of email (before the @ symbol)' do
      user = build(:user, email: 'johndoe@example.com')
      expect(user.truncated_email).to eq 'johndoe'
    end

    it 'truncates the first portion of email if email is very long' do
      user = build(:user, email: 'abcdefghijklmnopqrstuvwxyz@gmail.com')
      expect(user.truncated_email).to eq 'abcdefghijklmnopq...'
    end
  end
end
