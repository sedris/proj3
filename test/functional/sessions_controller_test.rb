require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  setup do
    @password = "test"
    @user = User.create(:username => "test", :password => @password )
  end

  test "should create session" do
    post :create, {password: @password, username: @user.username}
    assert (session[:user_id] == @user.id), "should be logged in, but session user_id is " + @response.body
  end

  test "should destroy session" do
    post :destroy
    assert (session[:user_id] == nil), "should be logged out, but session user_id is " + session[:user_id].to_s
  end
end
