class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
	before_filter :authenticate

	private
  # get current user from session
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

  # redirects to root if not logged in
	def authenticate
    if !current_user
    	@current_user = User.new()
      redirect_to root_path, :notice => "Must be logged in to view" and return
    end
  end
end
