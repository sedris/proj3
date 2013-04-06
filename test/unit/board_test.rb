require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "add and remove notes" do
  	user = users(:one)
  	board = user.add_board("board");

  	note1 = board.add_note()
	assert (board.notes.size == 1), "board should have one note"

  	note2 = board.add_note(:title => "title", :body => "body", :width => 20, :x => 200, :y => 100)
  	assert (board.notes.size == 2), "board should have two notes"

  	board.remove_note(note1)
  	assert (board.notes.size == 1), "board should have one note"
  end
end
