Rails.application.routes.draw do
  resources :deposits
  resources :customers
  resources :goods
  devise_for :cherubim_users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
