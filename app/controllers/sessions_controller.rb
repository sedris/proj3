class SessionsController < ApplicationController

  respond_to :http, :js
  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        #redirect_to root_url, :notice => "logged in"
    else
        flash.now.alert = "invalid email or password"
        #render "new"
    end
    json_response = { :user => user}
    respond_to do |format|
      format.json { render :json => json_response }
      format.all { render :text => "Only JSON supported at the moment"}
    end
    #render :partial => 'preview', :content_type => 'text/html'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url :notice=> "logged out"
  end

end
