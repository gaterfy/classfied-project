# frozen_string_literal: true

# Customer model
class Customer < ApplicationRecord
  has_many :classfieds
  validates_presence_of :name
  validates_numericality_of :rating
end
