class Note < ActiveRecord::Base
  belongs_to :board
  attr_accessible :body, :title, :width, :x, :y
end
