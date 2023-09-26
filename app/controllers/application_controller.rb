class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_info|
        user_info.permit(:email, :password, :password_confirmation, user_information_attributes: [:first_name, :last_name])
      end
    end
end
