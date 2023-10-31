class CherubimUsersController < ApplicationController
  def index; end

  def show
    @user = CherubimUser.find(current_cherubim_user.id)
  end

  def new; end
  
end
