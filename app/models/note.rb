class Note < ActiveRecord::Base
  belongs_to :board
  attr_accessible :body, :title, :width, :x, :y

  validate :validate_attrs

	# Requires: width > 0, x >= 0, y >= 0
	# Modifies: None.
	# Effects: 	Allows Note to save if valid, otherwise, does not save
  def validate_attrs
  	if self.width <= 0 or self.x < 0 or self.y < 0
  		return false
    end
    
  	return true
  end

  # Requires: valid strings and ints
  # Modifies: Attributes
  # Effects:  Updates attributes
  def update(title = self.title, body, width, x, y)
    self.update_attributes(:title => title, :body => body, :width => width, :x => x, :y =>y)
  end
end
