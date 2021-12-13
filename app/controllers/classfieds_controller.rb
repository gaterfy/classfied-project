# frozen_string_literal: true

# classfied controller
class ClassfiedsController < ApplicationController
  before_action :find_classified, only: :show

  def index
    render json: Classfied.all
  end

  def show
    render json: @classfied
  end

  private

  def find_classified
    @classfied = Classfied.find_by(id: params[:id])
    render json: {}, status: :not_found and return unless @classfied
  end
end
