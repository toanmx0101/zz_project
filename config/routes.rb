Rails.application.routes.draw do
  root to: 'home#home'
  devise_for :users
  resources :products, only: %i[show index] do
    collection do
      get 'search'
    end
  end
  resources :orders, except: %i[edit new]
  resources :cart, only: :index
  resources :categories, only: :index
end
