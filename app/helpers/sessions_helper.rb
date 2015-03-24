module SessionsHelper
	def current_user
		if session[:user_id]
			@current_user = User.find(session[:user_id]) if session[:user_id]
		elsif (user_id = cookies.signed[:user_id])
			user = User.find(user_id)
			if user && user.authenticated?(:remember, cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end

  def log_in(user)
  	session[:user_id] = user.id
  end

  def remember(user)
  	# create and add remember_digest for current user
  	user.remember
  	cookies.permanent.signed[:user_id] = user.id
  	cookies.permanent[:remember_token] = user.remember_token
  end

  def log_out
  	forget current_user
  	@current_user = nil
  	session.delete(:user_id)
  end

  def forget(user)
  	# remove remember_digest from user
  	user.forget
  	cookies.delete(:user_id)
  	cookies.delete(:remember_token)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

end
