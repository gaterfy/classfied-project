# frozen_string_literal: true

# classfied migrate
class CreateClassfieds < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
    create_table :classfieds, id: :uuid do |t|
      t.string :title
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
