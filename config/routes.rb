# frozen_string_literal: true

# Rails routes definition
Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'calendar', to: 'pages#calendar'

  # Seminars
  resources :seminars, only: %i[index show edit create update]
end
