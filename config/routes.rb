Rails.application.routes.draw do
  require 'sidekiq'
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: "home#index"
  devise_for :users
  resources :search_files, except: [:edit, :update]
  resources :search_results
end
