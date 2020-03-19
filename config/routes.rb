Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resources :search_files, except: [:edit, :update]
  resources :search_results
end
