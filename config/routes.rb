Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  resources "matches", except: [:edit, :update]

  post "/matches/:id/confirm", to: "matches#confirm"

  root to: "pages#home"
end
