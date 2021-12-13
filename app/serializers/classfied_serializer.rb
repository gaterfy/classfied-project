# frozen_string_literal: true

class ClassfiedSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :title,
             :price,
             :description
end
