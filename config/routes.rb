Rails.application.routes.draw do
  get 'sessions/new'
  post 'sessions/new', to: "sessions#create"
  get 'sessions/create'
  get 'sessions/destroy'
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/login'
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new create)



  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

end
