# frozen_string_literal: true

# classfied controller
class ClassfiedsController < ApplicationController
  def show
    render json: Classfied.find(params[:id])
  end
end
