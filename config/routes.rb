Rails.application.routes.draw do
  resources :users
  resources :sessions
  resources :password_resets

  root "welcome#index"

  ## CUSTOM ROUTES ##
  # password reset routes
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'

  # session routes
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  
  # users routes
  get "signup" => "users#new", :as => "signup"

  # articles routes
  get "/search" => "articles#search"  # search for articles
end
