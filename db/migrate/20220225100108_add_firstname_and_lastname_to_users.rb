# frozen_string_literal: true

# migration to add firstname and lastname
class AddFirstnameAndLastnameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
  end
end
