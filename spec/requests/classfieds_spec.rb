# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'classfieds', type: :request do
  describe 'GET /classfieds/id' do
    subject(:show) { get "/classfieds/#{classfied.id}" }
    let(:classfied) { FactoryBot.create(:classfied) }

    it 'returns json' do
      show

      expect(response).to have_http_status(200)
    end

    it 'is correctly serialized' do
      show

      expect(parsed_body).to match({
        id: classfied.id,
        user_id: classfied.user_id,
        title: classfied.title,
        price: classfied.price,
        description: classfied.description
      }.stringify_keys)
    end

    it 'returns not found when the resource can not be found' do
      get '/classfieds/trululu'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /classfieds' do
    subject(:index) { get '/classfieds' }
    before { FactoryBot.create_list(:classfied, 3) }

    it 'returns json' do
      index

      expect(response).to have_http_status(200)
    end

    it 'returns all the entries' do
      index

      expect(parsed_body.count).to eq(Classfied.count)
    end
  end
end
