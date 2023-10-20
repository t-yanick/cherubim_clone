class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :authenticate_cherubim_user!
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name,:last_name,:Dob :email,:Nic, :password, :password_confirmation) }
    end
end
