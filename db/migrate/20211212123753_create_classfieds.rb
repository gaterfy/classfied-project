# frozen_string_literal: true

# classfied migrate
class CreateClassfieds < ActiveRecord::Migration[6.1]
  def change
    create_table :classfieds do |t|
      t.string :title
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
