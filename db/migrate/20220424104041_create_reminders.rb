# frozen_string_literal: true

class CreateReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :number_of_notes, null: false

      t.timestamps
    end

    add_index :reminders, %i[user_id name], unique: true
  end
end
