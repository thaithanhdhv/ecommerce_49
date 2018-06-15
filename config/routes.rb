Rails.application.routes.draw do
  get "products/index"
  get "products/show"

  root "static_pages#home"
  root "sessions#new"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users
end
