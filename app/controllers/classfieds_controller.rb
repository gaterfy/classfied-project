# frozen_string_literal: true

# classfied controller
class ClassfiedsController < ApplicationController
  before_action :find_classified, only: %i[show update destroy]
  before_action :authenticate_user, only: %i[create update destroy]

  def create
    @classfied = current_user.classfieds.create(classfied_params)

    if @classfied.save
      render json:  @classfied, status: :created
    else
      render json:  @classfied.errors.details, status: :bad_request
    end
  end

  def index
    paginate json: Classfied.all
  end

  def show
    render json: @classfied
  end

  def update
    render json: {}, status: :forbidden and return unless @classfied.user.id == current_user.id

    if @classfied.update(classfied_params)
      render json: @classfied
    else
      render json: @classfied.errors.details, status: :bad_request
    end
  end

  def destroy
    render json: {}, status: :forbidden and return unless @classfied.user.id == current_user.id

    if @classfied.destroy
      render json: {}, status: :no_content
    else
      render json: @classfied.errors.details, status: :bad_request
    end
  end

  private

  def find_classified
    @classfied = Classfied.find_by(id: params[:id])
    render json: {}, status: :not_found and return unless @classfied
  end

  # strong parameters
  def classfied_params
    params.require(:classfied).permit(:title, :price, :description)
  end
end
