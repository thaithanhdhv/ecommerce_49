Rails.application.routes.draw do
  get "search_products/index"

  get "products/index"
  get "products/show"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/profile", to: "admin/users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, except: %i(destroy index)
  resources :search_products, only: :index
  namespace :admin do
    root "users#index"
    resources :users
  end
  resources :categories
end
