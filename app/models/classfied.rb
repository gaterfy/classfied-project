# frozen_string_literal: true

# classfied model
class Classfied < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  validates_presence_of :user, :price, :description, :title
  validates_numericality_of :price
end
