Rails.application.routes.draw do
  devise_for :users, skip: :sessions
  as :user do
    get "login", to: "devise/sessions#new", as: :new_user_session
    post "login", to: "devise/sessions#create", as: :user_session
    delete "logout", to: "devise/sessions#destroy", as: :destroy_user_session
  end
  root "static_pages#home"
  get "/fetch_items", to: "products#filter_product", as: "fetch_items"
  resources :search_products, only: :index
  resources :categories
  resources :products, only: %i(index show) do
    resources :comments
    resources :ratings, only: :create
  end
  resources :orders do
    resources :order_details, only: :index
  end
  namespace :admin do
    root "static_pages#home"
    resources :users
    resources :categories do
      resources :products
    end
    resources :products
    resources :orders do
      resources :order_details
    end
  end
  resources :carts, only: :index
  get "add_cart/:id_product", to: "carts#add_cart", as: :add_cart
  get "remove_cart/:id_product", to: "carts#remove_cart", as: :remove_cart
  put "orders/:id_order", to: "orders#cancel", as: :cancel
  put "update_hard_cart", to: "carts#update_hard_cart", as: :update_hard_cart
end
