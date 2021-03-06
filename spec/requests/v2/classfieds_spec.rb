# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'v2/classfieds', type: :request do
  describe 'GET /classfieds/:id' do
    subject(:show) { get "/v2/classfieds/#{classfied.id}" }
    let(:classfied) { FactoryBot.create(:classfied) }

    it 'works' do
      show

      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /classfieds' do
    context 'when unauthenticated' do
      it 'returns unauthorized' do
        post '/v2/classfieds'

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:classfied) { post '/v2/classfieds', params: params, headers: authentication_header }

      let(:params) do
        {
          classfied: {
            title: 'make it',
            price: 35,
            description: 'test v2 creation',
            customer_attributes: {
              name: 'wonder',
              rating: 3,
              is_recommended: true,
              footer_text: 'Noisy Baker Street'
            }
          }
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
          title: params[:classfied][:title],
          price: params[:classfied][:price],
          description: params[:classfied][:description]
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
        patch "/v2/classfieds/#{classfied.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:patch_classfied) do
        patch "/v2/classfieds/#{classfied.id}", params: params, headers: authentication_header
      end

      let(:params) do
        {
          classfied: { title: new_title }
        }
      end

      let(:new_title) { 'new title' }

      it 'returns forbidden status' do
        patch_classfied

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE /classfied/:id' do
    let(:classfied) { FactoryBot.create(:classfied, user: current_user) }

    context 'when unauthenticated' do
      it 'returns unauthorized' do
        delete "/v2/classfieds/#{classfied.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:destroy_classfied) do
        delete "/v2/classfieds/#{classfied.id}",
               headers: authentication_header
      end

      it 'deletes the given classified' do
        destroy_classfied

        expect(response).to have_http_status(:no_content)
        expect(Classfied.find_by(id: classfied.id)).to be_nil
      end

      it 'returns a not found when the resource can not be found' do
        delete '/v2/classfieds/tralala', headers: authentication_header

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a forbidden when the requester is not the owner of the resource' do
        antother_classfied = FactoryBot.create(:classfied)

        delete "/v2/classfieds/#{antother_classfied.id}", headers: authentication_header

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
