Rails.application.routes.draw do
  root to: 'home#home'
  devise_for :admin_users, ActiveAdmin::Devise.config
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { confirmations: 'users/confirmations' }
  resources :products do
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
  get 'who_purchased', to: 'home#who_purchased'
end
