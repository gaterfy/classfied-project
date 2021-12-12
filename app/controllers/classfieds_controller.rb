# frozen_string_literal: true

# classfied controller
class ClassfiedsController < ApplicationController
  def index
    render json: Classfied.all
  end

  def show
    render json: Classfied.find(params[:id])
  end
end
