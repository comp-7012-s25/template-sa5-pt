# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root to: redirect('albums')

  get 'albums', to: 'albums#index', as: 'albums'
  post 'albums', to: 'albums#create'
  get 'albums/new', to: 'albums#new', as: 'new_album'
  get 'albums/:id', to: 'albums#show', as: 'album'
  get 'albums/:id/edit', to: 'albums#edit', as: 'edit_album'
  patch 'albums/:id', to: 'albums#update'
  delete 'albums/:id', to: 'albums#destroy'
end
