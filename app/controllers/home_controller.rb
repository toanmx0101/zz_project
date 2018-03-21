class HomeController < ApplicationController
  before_action :authenticate_user!
  def home
    @products = current_user.products
  end
end
