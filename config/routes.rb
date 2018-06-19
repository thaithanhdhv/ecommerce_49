Rails.application.routes.draw do

  get "products/index"
  get "orders/index"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/profile", to: "admin/users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: %i(index)
  resources :categories
  resources :search_products, only: :index
  resources :products
  resource :cart, only: :show
  resources :oder_details, only: %i(create update destroy)
  resource :show_carts, only: :show
  resource :orders, only: :show
  resources :cart_items, only: %i(create update destroy)
  namespace :admin do
    root "users#index"
    resources :users, except: %i(show)
    resources :categories do
      resources :products
    end
    resources :products
  end
  resources :orders do
    resources :oder_details, only: :index
  end
end
