Rails.application.routes.draw do
  resources :search_results
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
  
  get "/ingredients/:id", to: "ingredients#show"
  post "/ingredients", to: "ingredients#create"
  patch "/ingredients/:id", to: "ingredients#update"
  delete "/ingredients/:id", to:"ingredients#destroy"

  get "/users", to: "users#index"
  get "/kitchens", to: "kitchens#index"
  get "/kitchens/:id", to: "kitchens#show"

  post "/recipesearch", to: "search_results#edamam_search"
  get "/searchindex", to: "search_results#index"
  post "/sendresults", to: "search_results#send_results"

  post "/ingredupdate", to: "search_results#update_ingred_of_result"
  
  post "/ingredmatchupdate", to: "search_results#update_results_ingredMatch"
  post "/ingredblockupdate", to: "search_results#update_results_ingredBlock"
  post "/ingredmatchundo", to: "search_results#undo_results_ingredMatch"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
