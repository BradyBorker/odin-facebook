Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'friendships#show'

  resources :users, only: [:index] do
    resource :user_information, only: [:index]
  end

  resource :friend_invitations, only: [:new, :create, :update, :destroy]

  resources :posts, only: [:index, :new, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :comments, only: [:new]

  resources :friendships, only: [:show, :create, :update, :destroy]
end
