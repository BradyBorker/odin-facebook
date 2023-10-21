Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'my_registrations' }
  
  # omniauth_callbacks: 'users/omniauth_callbacks' ## Place inside controllers above 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :users, only: [:index, :show, :edit, :update] do
    resource :user_information, only: [:edit]
  end

  resources :user_informations, only: [:update]
  resources :friend_invitations, only: [:create]

  resources :posts, only: [:index, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :comments, only: [:show] do
    resources :likes, only: [:create, :destroy]
  end

  resources :friendships, only: [:show, :create, :update, :destroy]
end
