class Note < ActiveRecord::Base
  attr_accessible :body, :height, :width, :x, :y

  #validate :validate_attrs
  before_create :set_defaults

	/# Requires: width > 0, x >= 0, y >= 0
	# Modifies: None.
	# Effects: 	Allows Note to save if valid, otherwise, does not save
  def validate_attrs
  	if self.width <= 0 or self.x < 0 or self.y < 0
  		return false
    end
    
  	return true
  end/

  # Requires: None
  # Modifies: Attributes
  # Effects:  Sets attribute defaults if empty
  def set_defaults
    self.body = self.body? ? self.body : ""
    self.width = self.width? ? self.width : 200
    self.height = self.height? ? self.height : 200
    self.x = self.x? ? self.x : 0
    self.y = self.y? ? self.y : 0
  end


  # Requires: valid strings and ints
  # Modifies: Attributes
  # Effects:  Updates attributes
  def update_note(body, width, height, x, y)
    body = body? ? body : self.body
    width = width? ? width : self.width
    height = height? ? height : self.height
    x = x? ? x : self.x
    y = y? ? y : self.x
    return self.update_attributes(:body => body, :width => width, :height => height, :x => x, :y =>y)
  end

end
