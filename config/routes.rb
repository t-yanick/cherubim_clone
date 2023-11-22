Rails.application.routes.draw do
  devise_for :cherubim_users
  resources :roles

  resources :deposits
  resources :customers do
    member do
      get 'index_c_g'
    end
  end
  resources :goods
  get '/onlycustomer', to: "customers#new_customer_only"
  post '/onlycustomer', to: "customers#create_only_customer"
  get '/deposit_statistics', to: 'deposits#statistics', as: 'deposit_statistics'
  get 'deposits/print_weekly_statistics', to: 'deposits#print_weekly_statistics'
  get '/generate_pdf', to: 'customers#generate_pdf', as: 'generate_pdf'
  root 'cherubim_users#show'
  resources :receipts do
    get 'download', on: :member
  end
  # post 'login', to: "cherubim_users#login"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  #  end
end
