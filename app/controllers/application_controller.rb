# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::API
  include Knock::Authenticable
end
