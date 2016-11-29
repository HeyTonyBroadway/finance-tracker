class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User" #friend is not a class, so we have to say what class it is
end
