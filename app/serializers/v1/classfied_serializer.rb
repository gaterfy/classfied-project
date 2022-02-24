# frozen_string_literal: true

module V1
  class ClassfiedSerializer < ActiveModel::Serializer
    attributes :id,
               :title,
               :price,
               :description
    belongs_to :user
  end
end
