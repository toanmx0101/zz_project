Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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
  resources :setup_language do
    collection do
      get 'vietnam'
      get 'english'
    end
  end
end
