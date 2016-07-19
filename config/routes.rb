Rails.application.routes.draw do

  resources :actors

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :movies do
    resources :reviews, only: [:new, :create]
  end

  resources :users, only: [:new, :create]

  resources :session, only: [:new, :create, :destroy]

  root to: 'movies#index'

end
