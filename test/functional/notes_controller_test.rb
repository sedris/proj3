require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  setup do
    @user = User.create(:username => "test", :password => "test")
    session[:user_id] = @user.id

    @note = notes(:one)
    @note2 = notes(:two)
  end

  test "should create note" do
    post :create, note: {body: @note.body, height: @note.height, width: @note.width, x: @note.x, y: @note.y}
    assert (@user.notes.size == 1), "got size: " + @user.notes.size.to_s + ", want: 1"
    assert (@user.notes.first.body == @note.body), "got: " + @user.notes.first.body + ", want: " + @note.body
    assert (@user.notes.first.height == @note.height), "got: " + @user.notes.first.height.to_s + ", want: " + @note.height.to_s
    assert (@user.notes.first.width == @note.width), "got: " + @user.notes.first.width.to_s + ", want: " + @note.width.to_s
    assert (@user.notes.first.x == @note.x), "got: " + @user.notes.first.x.to_s + ", want: " + @note.x.to_s
    assert (@user.notes.first.y == @note.y), "got: " + @user.notes.first.y.to_s + ", want: " + @note.y.to_s
  end

  test "should update note" do
    @n = @user.notes.create(body: @note.body, height: @note.height, width: @note.width, x: @note.x, y: @note.y)

    put :update, id: @n.id, body: @note2.body, height: @note2.height, width: @note2.width, x: @note2.x, y: @note2.y
    assert (@user.notes.first.body == @note2.body), "got: " + @user.notes.first.body + ", want: " + @note2.body
    assert (@user.notes.first.height == @note2.height), "got: " + @user.notes.first.height.to_s + ", want: " + @note2.height.to_s
    assert (@user.notes.first.width == @note2.width), "got: " + @user.notes.first.width.to_s + ", want: " + @note2.width.to_s
    assert (@user.notes.first.x == @note2.x), "got: " + @user.notes.first.x.to_s + ", want: " + @note2.x.to_s
    assert (@user.notes.first.y == @note2.y), "got: " + @user.notes.first.y.to_s + ", want: " + @note2.y.to_s
  end

  test "should destroy note" do
   @user.notes.create(body: @note.body, height: @note.height, width: @note.width, x: @note.x, y: @note.y)
   delete :destroy, id: @user.notes.first.id
   assert (@user.notes.size == 0)
  end
end
