module Users
  class ConfirmationsController < Devise::ConfirmationsController
    protected

    def after_confirmation_path_for(_resource_name, _resource)
      sign_in(_resource)
      root_path
    end
  end
end
