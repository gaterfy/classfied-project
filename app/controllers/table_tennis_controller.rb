# frozen_string_literal: true

# tableTennisController
class TableTennisController < ApplicationController
  def ping
    if current_user
      render json: { response: 'authorized pong' }
    else
      render json: { response: 'unauthorized pong' }
    end
  end
end
