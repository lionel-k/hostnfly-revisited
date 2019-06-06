# frozen_string_literal: true

Rails.application.routes.draw do
  resources :listings do
    resources :bookings
    resources :reservations
  end
  resources :missions, only: [:index]
  root to: "listings#index"
end
