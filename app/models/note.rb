# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user
  has_rich_text :content

  validates :content, presence: true

  def self.sample(count = 1)
    find(pluck(:id)).sample(count)
  end
end
