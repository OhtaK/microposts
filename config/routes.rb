Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'signup',  to: 'users#new'
  
  resources :users do
   member do
     get 'followings'
     get 'followers'
   end
 end
 
  resources :microposts
  resources :relationships, only: [:create, :destroy]
end
