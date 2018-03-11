class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :application_layout

  private

  def application_layout
    user_signed_in? ? 'application' : 'signed_in_application'
  end
end
