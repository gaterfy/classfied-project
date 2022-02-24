# frozen_string_literal: true

# user controller
module V1
  # User controller
  class UsersController < ApplicationController
    before_action :authenticate_user

    def show
      # binding.pry
      render json: current_user
    end
  end
end
