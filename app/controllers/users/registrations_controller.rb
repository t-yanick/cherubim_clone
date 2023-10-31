class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @new_cherubim_user = CherubimUser.new
  end

  def create
    @user = CherubimUser.new(registraion_params)
    return if @user.save redirect_to @user_path

    render 'new'
  end

  private

  def registraion_params
    params.require(:cherubim_user).permit(:first_name, :last_name, :Dob, :Nic, :email, :password)
  end
end
