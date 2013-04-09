require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  /test "set defaults" do
  	note = Note.create()
  	assert (note.body == ""), "default body should be blank"
  	assert (note.x == 0), "default x should be 0"
  	assert (note.y == 0), "default y should be 0"
  	assert (note.width == 200), "default width should be 200"
  	assert (note.height == 200), "default height should be 200"
  end/
end
