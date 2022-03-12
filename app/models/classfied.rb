# frozen_string_literal: true

# classfied model
class Classfied < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :customer
  has_one_attached :file

  validates_presence_of :user, :price, :description, :title
  validates_numericality_of :price

  before_save :set_user

  accepts_nested_attributes_for :customer, allow_destroy: true

  private

  def set_user
    self.user = User.take
  end
end
