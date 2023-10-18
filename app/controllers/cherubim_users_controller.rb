class CherubimUsersController < ApplicationController
  before_action :authenticate_cherubim_user!
  def show
    @user = CherubimUser.find(current_cherubim_user.id)
  end
end
