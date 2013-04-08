class SessionsController < ApplicationController
  skip_before_filter :authenticate, :only => [:new, :create]
  
  respond_to :http, :js
  def new
  end

  def create
    /user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_url, :notice => "logged in"
    else
        flash.now.alert = "invalid email or password"
        render "new"
    end/
      
      user = User.find_by_username(params[:username])
      respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        format.html { redirect_to notes_url }
        format.json { head :no_content }
      else
        format.html { render :text => "error" }
        format.json { render json: {:error => "invalid email or password"}, status: :unprocessable_entity }
      end
    end
    #render :partial => 'preview', :content_type => 'text/html'
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url :notice=> "logged out"
  end

end
