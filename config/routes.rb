Rails.application.routes.draw do
  devise_for :cherubim_users
  resources :roles

  resources :deposits
  resources :customers
  resources :goods
  root 'cherubim_users#show'
  # post 'login', to: "cherubim_users#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  #  end
end
