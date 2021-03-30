Rails.application.routes.draw do
  resources :search_results, only: [:edamam_search]
  resources :icons
  resources :ingredients
  resources :recipes
  resources :kitchens
  resources :users, only: [:create]
  post "/login", to: "users#login"
  get "/autologin", to: "users#autologin"
 
  get "/kitchenuser", to: "kitchens#kitchen_user"
  post "/kitchens", to: "kitchens#create"
  patch "/kitchens/:id", to: "kitchens#update"
  delete "/kitchens/:id", to: "kitchens#destroy"
  
  post "/ingredients", to: "ingredients#create"
  patch "/ingredients/:id", to: "ingredients#update"
  delete "/ingredients/:id", to:"ingredients#destroy"

  get "/users", to: "users#index"
  get "/kitchens", to: "kitchens#index"
  get "/kitchens/:id", to: "kitchens#show"

  post "/recipesearch", to: "search_results#edamam_search"
  get "/searchindex", to: "search_results#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
