Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # Temporary root path:
  root 'friendships#index'

  resources :friendships, only: [:index, :show, :create, :update, :destroy]
end
