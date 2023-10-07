Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :users, only: [:index, :show]

  resource :friend_invitations, only: [:create, :destroy]

  resources :posts, only: [:index, :new, :create] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  resources :friendships, only: [:show, :create, :update, :destroy]
end
