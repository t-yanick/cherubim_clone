class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_cherubim_user!
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:first_name, :last_name, :Dob, :Nic)
end
