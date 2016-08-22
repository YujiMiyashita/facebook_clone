class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:name, :email)
      end

      devise_parameter_sanitizer.permit(:account_update) do |user_params|
        user_params.permit(:name, :email)
      end
    end
end
