Rails.application.routes.draw do
  root 'products#index'

  devise_for :users, controllers: { registrations: "registrations" }

  resources :products

  resources :profiles

  resources :artists do
    resources :members
  end

  resources :artists do
    resources :releases
  end

  resources :conversations do
    resources :messages
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
