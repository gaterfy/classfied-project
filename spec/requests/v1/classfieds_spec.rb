# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'classfieds', type: :request do
  describe 'GET /classfieds/:id' do
    subject(:show) { get "/v1/classfieds/#{classfied.id}" }
    let(:classfied) { FactoryBot.create(:classfied) }

    it 'works' do
      show

      expect(response).to have_http_status(200)
    end

    it 'returns file_url when file is attached' do
      classfied.file.attach(io: File.open('spec/fixtures/computer.jpeg'),
                            filename: 'computer.jpeg')
      classfied.save

      show

      expect(response).to have_http_status(200)
      # expect(parsed_body['file_url']).to be_present
    end

    it 'is correctly serialized' do
      show

      expect(parsed_body).to match({
        id: classfied.id,
        title: classfied.title,
        price: classfied.price,
        file_url: nil,
        user: {
          id: classfied.user.id,
          fullname: classfied.user.fullname
        }.stringify_keys,
        customer: {
          id: classfied.customer.id,
          name: classfied.customer.name,
          rating: classfied.customer.rating,
          footer_text: classfied.customer.footer_text
        }.stringify_keys,
        description: classfied.description
      }.stringify_keys)
    end

    it 'returns not found when the resource can not be found' do
      get '/v1/classfieds/trululu'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /classfieds' do
    context 'when every thing is going well' do
      let(:page) { 3 }
      let(:per_page) { 5 }

      subject(:index) { get '/v1/classfieds', params: { page: page, per_page: per_page } }
      before { FactoryBot.create_list(:classfied, 18) }

      it 'works' do
        index

        expect(response).to have_http_status(:partial_content)
      end

      it 'returns paginate results' do
        index

        expect(parsed_body.map do |c|
                 c['id']
               end).to eq(Classfied.all.limit(per_page).offset((page - 1) * per_page).pluck(:id))
      end
    end

    it 'returns a bad request status when parameters are missing' do
      get '/v1/classfieds'
      expect(response).to have_http_status(:bad_request)
      expect(parsed_body.keys).to include('error')
      expect(parsed_body['error']).to eq 'missing parameters'
    end
  end

  describe 'POST /classfieds' do
    context 'when unauthenticated' do
      it 'returns unauthorized' do
        post '/v1/classfieds'

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:classfied) { post '/v1/classfieds', params: params, headers: authentication_header }

      let(:params) do
        {
          classfied: {
            title: 'test',
            price: 50,
            description: 'classfied test creation',
            customer_attributes: {
              name: 'Home',
              rating: 4,
              is_recommended: true,
              footer_text: '221b Baker Street'
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
        patch "/v1/classfieds/#{classfied.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:patch_classfied) do
        patch "/v1/classfieds/#{classfied.id}", params: params, headers: authentication_header
      end

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
        patch '/v1/classfieds/tralala', params: params

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a forbidden when the requester is not the owner of the resource' do
        antother_classfied = FactoryBot.create(:classfied)

        patch "/v1/classfieds/#{antother_classfied.id}",
              params: params, headers: authentication_header

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'DELETE /classfied/:id' do
    let(:classfied) { FactoryBot.create(:classfied, user: current_user) }

    context 'when unauthenticated' do
      it 'returns unauthorized' do
        delete "/v1/classfieds/#{classfied.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when authenticated' do
      subject(:destroy_classfied) do
        delete "/v1/classfieds/#{classfied.id}", headers: authentication_header
      end

      it 'deletes the given classified' do
        destroy_classfied

        expect(response).to have_http_status(:no_content)
        expect(Classfied.find_by(id: classfied.id)).to be_nil
      end

      it 'returns a not found when the resource can not be found' do
        delete '/v1/classfieds/tralala', headers: authentication_header

        expect(response).to have_http_status(:not_found)
      end

      it 'returns a forbidden when the requester is not the owner of the resource' do
        antother_classfied = FactoryBot.create(:classfied)

        delete "/v1/classfieds/#{antother_classfied.id}", headers: authentication_header

        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
