Rails.application.routes.draw do
  resources :users
  resources :groups
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  root to: "dashboard#index"
  
end
