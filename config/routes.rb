Rails.application.routes.draw do
  devise_for :users
  resources :products do
    collection do
      get 'search'
    end
  end
  resources :orders, except: [:edit, :new]
  root to: 'home#home'
  resources :cart, only: :index 
end
