# frozen_string_literal: true

class Reminder < ApplicationRecord
  belongs_to :user

  DEFAULT_NUMBER_OF_NOTES = 3
  DEFAULT_NAME = 'Default reminder'

  attribute :name, :string, default: DEFAULT_NAME
  attribute :number_of_notes, :integer, default: DEFAULT_NUMBER_OF_NOTES

  validates :name, presence: true, uniqueness: { scope: :user_id }
  validate :number_of_notes, :validate_number_of_notes

  def validate_number_of_notes
    # rubocop:disable Style/IfUnlessModifier, Style/GuardClause
    unless number_of_notes in 1..10
      errors.add(:number_of_notes, 'must be a number between 1 and 10')
    end
    # rubocop:enable Style/IfUnlessModifier, Style/GuardClause
  end
end
