Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users
  root to: "pages#home"

  resources :cars, only: [:index, :show, :new, :create] do
    resources :bookings, only: [:index, :create]
  end

  resources :bookings, only: [:index, :update]

  namespace :owner do
    resources :bookings, only: [:index]
  end

end
