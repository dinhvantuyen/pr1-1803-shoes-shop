Rails.application.routes.draw do
  root "home_pages#home"
  get  "/signup",  to: "users#new"
  post "/signup",  to: "users#create"
  get    "/login",   to: "sessions#new"
  post   "/login",   to: "sessions#create"
  delete "/logout",  to: "sessions#destroy"
  resources :users
  namespace :admin do
    root "dashboard#index"
    get "dashboard/index"
    resources :products
  end
end
