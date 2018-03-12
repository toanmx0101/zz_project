class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :application_layout

  private

  def application_layout
    user_signed_in? ? 'signed_in_application' : 'application'
  end
end
