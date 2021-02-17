Rails.application.routes.draw do
  resources :icons
  resources :ingredients
  resources :recipes
  resources :kitchens
  resources :users, only: [:create]
  post "/login", to: "users#login"
  get "/autologin", to: "users#autologin"
  delete "/kitchens/:id", to: "kitchens#destroy"
  patch "/kitchens/:id", to: "kitchens#update"
  post "/kitchens", to: "kitchens#create"
  get "/kitchenuser", to: "kitchens#kitchen_user"
  get "/users", to: "users#index"
  get "/kitchens", to: "kitchens#index"
  get "/kitchens/:id", to: "kitchens#show"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
