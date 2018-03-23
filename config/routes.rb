Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources "matches", except: [:edit, :update]
  post "/matches/:id/confirm", to: "matches#confirm"

  resources "users", only: [:show]
  resources "comments", only: [:create]

  root to: "pages#home"
end
