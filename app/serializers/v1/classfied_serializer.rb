# frozen_string_literal: true

module V1
  # classfied serializer
  class ClassfiedSerializer < ActiveModel::Serializer
    attributes :id,
               :title,
               :price,
               :description,
               :file_url

    belongs_to :user
    belongs_to :customer

    def file_url
      return unless object.file.attached?

      Rails.application.routes.url_helpers
           .rails_blob_path(object.file, disposition: 'attachment', only_path: true)
    end
  end
end
