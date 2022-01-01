Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'home/homepage' => 'home#homepage'
  resources :instagrams do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy] do
      resources :comment_likes, only: [:create, :destroy]
    end
  end
  resources :relationships, only: [:create, :destroy]

end
