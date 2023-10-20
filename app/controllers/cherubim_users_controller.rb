class CherubimUsersController < ApplicationController
  def show
    @user = CherubimUser.find(current_cherubim_user.id)
  end
end
