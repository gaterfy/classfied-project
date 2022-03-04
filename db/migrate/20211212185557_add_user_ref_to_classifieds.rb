# frozen_string_literal: true

# add user reference
class AddUserRefToClassifieds < ActiveRecord::Migration[6.1]
  def change
    add_reference :classfieds, :user, type: :uuid, null: false, foreign_key: true
  end
end
