class List < ActiveRecord::Base
  attr_accessible :height, :width, :x, :y
  belongs_to :user
  has_many :tasks, :dependent => :destroy
  
  # optional title, displays 'untitled' when clicked on if no title exits, otherwise has title
  # new task: hitting enter causes new task to be shown below other task
  # delete task: empty body
  
  # questionsL
  # call two controllers for one view?
  # add back board?
  #
  # board_controller
  # index - returns @notes and @lists
  # use note and list controller for everything else

end
