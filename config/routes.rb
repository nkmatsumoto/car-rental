Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :cars, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:index, :create]
  end

  resources :bookings, only: [:index, :update]

  namespace :owner do
    get 'bookings/index'
    resources :bookings, only: [:index]
  end

end
