class Note < ActiveRecord::Base
  attr_accessible :body, :height, :width, :x, :y

  before_create :set_defaults

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
end
