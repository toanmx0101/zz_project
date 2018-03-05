Rails.application.routes.draw do
  devise_for :users
  resource :products
  resource :categories
  resource :orders
end
