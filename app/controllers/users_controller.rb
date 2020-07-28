class UsersController < ApplicationController
  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id]=user.id
      redirect_to '/'
    else
      redirect_to '/signup',notice:"An error occured"
    end
  end

  private
  def user_params
    permitted = params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
    permitted[:email] = permitted[:email].strip.downcase
    return permitted
  end
end
