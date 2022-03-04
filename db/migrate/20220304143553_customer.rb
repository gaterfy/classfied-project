# frozen_string_literal: true

# Customer migration table
class Customer < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        create_table :customers, id: :uuid do |t|
          t.integer :rating
          t.string :name
          t.boolean :is_recommended
          t.string :website
          t.text :footer_text

          t.timestamps
        end
      end
      dir.down do
        remove_table :customers
      end
    end
  end
end
