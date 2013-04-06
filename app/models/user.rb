class User < ActiveRecord::Base
  attr_accessible :password, :username
	has_secure_password
	validates_presence_of :password, :on => :create
	validates_uniqueness_of :username, :on => :create

	has_many :boards, :dependent => :destroy

	# Requires: "name" is valid string
	# Modifies: Boards associated with user
	# Effects: 	Creates new board for user
	# 			Board is named "Board [board_id]" if no name given
	# 			Returns board
	def add_board(name = '')
		self.boards.create(:name => name)
		if (name.empty?)
			self.boards.last.update_attribute(:name, "Board " + self.boards.last.id.to_s())
		end
		return self.boards.last
	end

	# Requires: "board_id" valid int
	# Modifies: Boards associated with user
	# Effects: 	Destroys board and associated notes
	def remove_board(board_id)
		board = self.boards.find_by_id(board_id)
		if (board)
			board.notes.destroy_all()
			self.boards.destroy(board_id)
		end
	end
end
