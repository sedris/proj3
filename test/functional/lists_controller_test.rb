require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:username => "test", :password => "test")
    session[:user_id] = @user.id

    @list = lists(:one)
  end

  test "should create list" do
    List.destroy_all()
    post :create, list: { height: @list.height, width: @list.width, x: @list.x, y: @list.y}
    assert (List.all.size == 1), List.all.size.to_s()
  end
end
