# frozen_string_literal: true

class Reminder < ApplicationRecord
  belongs_to :user

  DEFAULT_NUMBER_OF_NOTES = 3

  attribute :number_of_notes, :integer,
            default: DEFAULT_NUMBER_OF_NOTES

  validates :number_of_notes,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 10
            }
end
