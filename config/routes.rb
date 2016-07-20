Rails.application.routes.draw do

  resources :actors

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  resources :users

  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do 
    resources :users, only: [:index]
  end

  root to: 'movies#index'

end
