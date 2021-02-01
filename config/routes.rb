Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'pass_word_reset/new'
  get 'pass_word_reset/edit'
  get 'sessions/new'
  post 'sessions/new', to: "sessions#create"
  get 'sessions/create'
  get 'sessions/destroy'
  delete 'sessions/destroy'
  root 'static_pages#home'
  get 'static_pages/help'
  get 'static_pages/login'
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
  resources :account_activations, only: :edit
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy] or
  resources :microposts, except: [:index, :new, :edit, :show, :update]
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: %i(new create)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
