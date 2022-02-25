# frozen_string_literal: true

module V1
  class UserSerializer < ActiveModel::Serializer
    attributes :id,
               :firstname,
               :lastname,
               :username
  end
end
