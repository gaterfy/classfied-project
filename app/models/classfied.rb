# frozen_string_literal: true

# classfied model
class Classfied < ApplicationRecord
  belongs_to :user

  validates_presence_of :user
end
