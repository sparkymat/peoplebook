# frozen_string_literal: true
Rails.application.routes.draw do
  devise_for :users

  resources :people, path: "p", only: %i[show]

  # Defines the root path route ("/")
  root "home#index"
end
