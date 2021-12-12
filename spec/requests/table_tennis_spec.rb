# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Table Tennis Api', type: :request do
  describe '#ping' do
    context 'when unauthenticated' do
      before { get '/ping' }

      it 'works' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns unauthorized response' do
        expect(parsed_body['response']).to eq('unauthorized pong')
      end
    end

    context 'when authenticated' do
      before { get '/ping', headers: authentication_helper }

      it 'works' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns authorized response' do
        expect(parsed_body['response']).to eq('authorized pong')
      end
    end
  end
end
