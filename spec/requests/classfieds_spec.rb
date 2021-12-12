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

      expect(parsed_body['id']).to eq(classfied.id)
      expect(parsed_body['title']).to eq(classfied.title)
      expect(parsed_body['description']).to eq(classfied.description)
      expect(parsed_body['price']).to eq(classfied.price)
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
