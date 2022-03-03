# frozen_string_literal: true

# migration to enable pgcrypto
class EnableUuid < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto'
  end
end
