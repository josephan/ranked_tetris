# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :comments
    resources :matches

    root to: "users#index"
  end

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources 'matches', except: %i[edit update]
  post '/matches/:id/confirm', to: 'matches#confirm'

  resources 'users', only: [:show]
  resources 'comments', only: [:create]

  get "/slack/oauth", to: "slack#oauth"
  delete "/slack/oauth", to: "slack#destroy"

  get "/profile", to: "pages#profile"
  patch "/profile", to: "pages#update_profile"
  put "/profile", to: "pages#update_profile"
  get "/stream", to: "pages#stream"
  get "/hall-of-fame", to: "pages#hall_of_fame"
  root to: 'pages#home'
end
