require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @password = "test"
    @user = User.create(:username => "test", :password => @password )
    session[:user_id] = @user.id
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: { password: "test1", username: "test1" }
    end
  end

end
