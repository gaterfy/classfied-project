# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'GET /users/:id' do
    subject(:show) { get "/v2/users/#{current_user.id}", headers: authentication_header }

    it 'returns json' do
      show

      expect(response).to have_http_status(200)
    end

    it 'is correctly serialized' do
      show

      expect(parsed_body).to match({
        id: current_user.id,
        firstname: current_user.firstname,
        lastname: current_user.lastname,
        username: current_user.username
      }.stringify_keys)
    end
  end
end
