Rails.application.routes.draw do
  root 'profiles#index'
  
  devise_for :users
  resources :profiles
  resources :artists
  resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
