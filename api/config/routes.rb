# frozen_string_literal: true

Rails.application.routes.draw do
  resources :listings do
    resources :bookings
    resources :reservations
  end
end
