Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  # Temporary root path:
  root 'posts#index'

  resources :users, only: [:index] do
    resource :user_information, only: [:index]
    resources :posts, only: [:index, :new, :create]
  end

  resources :posts, only: [:index] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :comments, only: [:new]

  resources :friendships, only: [:show, :create, :update, :destroy]
end
