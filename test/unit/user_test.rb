require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add and remove board" do
    one = users(:one)
    assert (one.boards.empty?), "user should not have any boards"

    board1 = one.add_board()
    assert (one.boards.size == 1), "user should have one board"
    assert (board1.name == "Board " + board1.id.to_s()), "board should have name 'Board " + board1.id.to_s() + "'"
    
    board2 = one.add_board("test")
    assert (one.boards.size == 2), "user should have one board"
    assert (board2.name == "test"), "board should have name 'test'"

    one.remove_board(board2.id)
    assert (one.boards.size == 1), "user should have one board"
    assert (one.boards.first.name == "Board " + board1.id.to_s()), "board should have name 'Board " + board1.id.to_s() + "'"
  end
end
