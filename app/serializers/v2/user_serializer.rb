# frozen_string_literal: true

module V2
  # user serializer
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :firstname, :lastname, :username
  end
end
