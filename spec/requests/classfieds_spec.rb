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
        title: classfied.title,
        price: classfied.price,
        user: {
          id: classfied.user.id,
          fullname: classfied.user.fullname
        }.stringify_keys,
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

  describe 'POST /classfieds' do
    context 'when unauthenticated' do
      it 'returns unauthorized' do
        post '/classfieds'

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:classfied) { post '/classfieds', params: params, headers: authentication_header }

      let(:params) do
        {
          classfied: { title: 'test', price: 50, description: 'classfied test creation' }
        }
      end

      it 'returns works' do
        classfied
        expect(response).to have_http_status(:created)
      end

      it 'creates a new classfied' do
        expect { classfied }.to change(Classfied, :count).by(1)
      end

      it 'has correct field values for the created classfied' do
        classfied
        created_classfied = current_user.classfieds.last

        expect(created_classfied.slice(:description, :title, :price)).to match({
          title: 'test',
          price: 50,
          description: 'classfied test creation'
        }.stringify_keys)
      end

      it 'returns a bad request when a parameter is missing' do
        params[:classfied].delete(:price)
        classfied
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a bad request when a parameter is missing' do
        params[:classfied][:price] = 'trululu'
        classfied
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /classfied/:id' do
    let(:classfied) { FactoryBot.create(:classfied, user: current_user) }

    context 'when unauthenticated' do
      it 'returns unauthorized' do
        patch "/classfieds/#{classfied.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:patch_classfied) { patch "/classfieds/#{classfied.id}", params: params, headers: authentication_header }

      let(:params) do
        {
          classfied: { title: new_title }
        }
      end

      let(:new_title) { 'new title' }

      context 'when every thing goes well' do
        it 'is expected to be success' do
          patch_classfied

          expect(response).to have_http_status(:success)
        end

        it 'updates title' do
          expect(classfied.title).not_to eq(new_title)

          patch_classfied

          expect(classfied.reload.title).to eq(new_title)
        end
      end

      it 'returns a bad request when a parameter is malformed' do
        params[:classfied][:price] = 'trululu'

        patch_classfied

        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a not_found when a resource can not be found' do
        patch '/classfieds/tralala', params: params

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a forbidden when the requester is not the owner of the resource' do
        antother_classfied = FactoryBot.create(:classfied)

        patch "/classfieds/#{antother_classfied.id}", params: params, headers: authentication_header

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE /classfied/:id' do
    let(:classfied) { FactoryBot.create(:classfied, user: current_user) }

    context 'when unauthenticated' do
      it 'returns unauthorized' do
        delete "/classfieds/#{classfied.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:destroy_classfied) { delete "/classfieds/#{classfied.id}", headers: authentication_header }

      it 'deletes the given classified' do
        destroy_classfied

        expect(response).to have_http_status(:no_content)
        expect(Classfied.find_by(id: classfied.id)).to be_nil
      end

      it 'returns a not found when the resource can not be found' do 
        delete '/classfieds/tralala', headers: authentication_header

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a forbidden when the requester is not the owner of the resource' do
        antother_classfied = FactoryBot.create(:classfied)

        delete "/classfieds/#{antother_classfied.id}", headers: authentication_header

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
