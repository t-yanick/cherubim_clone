class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_cherubim_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name,:email,:password,:password_confirmation, :Dob, :Nic)
    end
  end
end
