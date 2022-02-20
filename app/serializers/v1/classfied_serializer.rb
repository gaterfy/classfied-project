# frozen_string_literal: true

class ClassfiedSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :price,
             :description
  belongs_to :user
end
