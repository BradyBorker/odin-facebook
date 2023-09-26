Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # Temporary root path:
  root 'friendships#index'

  resources :users, only: [:index] do
    resource :user_information, only: [:index]
    resources :posts, only: [:index]
  end

  resources :posts, only: [:index]

  resources :friendships, only: [:index, :show, :create, :update, :destroy]
end
