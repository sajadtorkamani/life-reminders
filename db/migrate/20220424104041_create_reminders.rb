# frozen_string_literal: true

class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :number_of_notes, null: false

      t.timestamps
    end
  end
end
