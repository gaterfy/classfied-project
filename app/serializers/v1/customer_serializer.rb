# frozen_string_literal: true

module V1
  # customer serializer
  class CustomerSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :rating,
               :footer_text
  end
end
