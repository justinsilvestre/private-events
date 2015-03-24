class UsersController < ApplicationController
  def new
    redirect_to current_user if current_user
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  private

  	def user_params
  		params.require(:user).permit(:email, :name, :password, :password_confirmation)
  	end
end
