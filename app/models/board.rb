class Board < ActiveRecord::Base
  belongs_to :user
  attr_accessible :name
  has_many :notes, :dependent => :destroy

	# Requires: strings and ints are valid
	# Modifies: Notes associated with board
	# Effects: 	Creates new note for board
	# 			    Defaults set if parameters not given
  #           Returns note
  def add_note(title = "", body = "", width = 100, x = 0, y = 0)
  	return self.notes.create(:title => title, :body => body, :width => width, :x => x, :y =>y)
  end

	# Requires: "note_id" valid int
	# Modifies: Notes associated with board
	# Effects: 	Destorys note
  def remove_note(note_id)
  	note = self.notes.find_by_id(note_id)
	if (note)
  		self.notes.destroy(note_id)
  	end
  end
end
