Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources "matches", only: [:index, :new, :create, :show]

  post "/matches/:id/confirm", to: "matches#confirm"

  root to: "pages#home"
end
