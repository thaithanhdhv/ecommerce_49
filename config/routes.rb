Rails.application.routes.draw do
  get "products/index"
  get "products/show"

  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "/profile", to: "admin/users#show"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: %i(edit show update)
  namespace :admin do
    root "users#index"
    resources :users
  end
end
