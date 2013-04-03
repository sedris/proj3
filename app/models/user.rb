class User < ActiveRecord::Base
  attr_accessible :password, :username
	has_secure_password
	validates_presence_of :password, :on => :create
	validates_uniqueness_of :username, :on => :create

	has_many :boards
end
