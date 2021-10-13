Rails.application.routes.draw do
  resources :posts
  resources :users
  
  get 'main', to:"users#main"
  
  get 'create_fast', to:"users#create_fast"
  
  post 'login', to:"users#login"
  get 'show_post', to:"users#show_post"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
