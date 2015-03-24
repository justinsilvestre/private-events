class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		if params[:session][:remember_me] == '1'
  			remember user
  		else
  			forget user
  		end
  		flash[:success] = "Logged in as #{current_user.name}."
  		redirect_to root_url
  	else
  		flash.now[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	log_out unless current_user.nil?
  	flash[:success] = "You have been logged out."
  	redirect_to root_url
  end


end
