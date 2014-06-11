Rails.application.routes.draw do
  root "welcome#index"

  get 'password_resets/create'

  get 'password_resets/edit'

  get 'password_resets/update'

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :sessions
  resources :password_resets
end
