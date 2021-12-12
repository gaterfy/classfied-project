# frozen_string_literal: true

module AuthenticationHelper
  def current_user
    @current_user ||= FactoryBot.create(:user)
  end

  def authentication_helper
    token = Knock::AuthToken.new(payload: { sub: current_user.id }).token
    {
      'Authorization': "Bearer #{token}"
    }
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelper, type: :request
end
