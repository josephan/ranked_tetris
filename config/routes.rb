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

  root to: 'pages#home'
end
