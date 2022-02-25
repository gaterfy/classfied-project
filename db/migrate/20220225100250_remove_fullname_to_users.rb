# frozen_string_literal: true

# remove fullname to users table
class RemoveFullnameToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :fullname
  end
end
