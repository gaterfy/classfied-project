# frozen_string_literal: true

module V1
  class ClassfiedSerializer
    class UserSerializer < ActiveModel::Serializer
      attributes :id, :fullname
    end
  end
end
