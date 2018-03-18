Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources "matches", only: [:index, :new, :create, :show]

  root to: "pages#home"
end
