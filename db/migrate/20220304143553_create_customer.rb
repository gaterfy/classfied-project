# frozen_string_literal: true

# Customer migration table
class CreateCustomer < ActiveRecord::Migration[6.1]
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
        add_reference :classfieds, :customer, type: :uuid, null: false, foreign_key: true
      end
      dir.down do
        drop_table :customers
        remove_reference :classfieds, :customer, type: :uuid, null: false, foreign_key: true
      end
    end
  end
end
