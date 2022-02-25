# frozen_string_literal: true

module V2
  # classfied controller
  class ClassfiedsController < V1::ClassfiedsController
    def update
      render json: {}, status: :forbidden
    end
  end
end
