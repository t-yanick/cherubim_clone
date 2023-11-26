class CherubimUsersController < ApplicationController
  def index; end

  def show
    @user = CherubimUser.find(current_cherubim_user.id)
    @resource_name = :cherubim_user
  end

  def new; end
end
