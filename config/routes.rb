# frozen_string_literal: true

Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'ping', to: 'table_tennis#ping'

  concern :api_base do
    resources :classfieds, only: %i[index show create update destroy]
    resources :users, only: :show
  end

  namespace :v1 do
    concerns :api_base
  end

  namespace :v2 do
    concerns :api_base
  end
end
