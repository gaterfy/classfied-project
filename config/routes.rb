# frozen_string_literal: true

Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'ping', to: 'table_tennis#ping'

  resources :classfieds, only: %i[index show create update]
end
