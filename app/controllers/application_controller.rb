class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  private
  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end
end
