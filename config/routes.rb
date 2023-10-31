Rails.application.routes.draw do
  devise_for :cherubim_users
  get 'cherubim_users/index'
  get 'cherubim_users/show'
  get 'cherubim_users/new'
  # resources :devises
  resources :roles

  resources :deposits
  resources :customers
  resources :goods
  # post 'new_user', to: 'users/registrations#create'
  root 'cherubim_users#show'
  # post 'login', to: "cherubim_users#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  #  end
end
