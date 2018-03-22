class HomeController < ApplicationController
  before_action :authenticate_user!
  def home
    @products = current_user.products
  end

  def who_purchased
    @user_purchased_orders = OrderDetail.who_purchased_products(current_user.products)
  end
end
