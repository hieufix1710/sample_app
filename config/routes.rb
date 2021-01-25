Rails.application.routes.draw do
  get "static_pages/home"
  get "static_pages/help"
  scope "(:locale)", locale: /en|vi/ do
    resources :microposts
    resources :users
  end
end
