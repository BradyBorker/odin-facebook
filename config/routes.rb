Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'my_registrations' }
  
  # omniauth_callbacks: 'users/omniauth_callbacks' ## Place inside controllers above 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :users, only: [:index, :show, :edit, :update]

  resource :friend_invitations, only: [:create, :destroy]

  resources :posts, only: [:index, :new, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :friendships, only: [:show, :create, :update, :destroy]
end
