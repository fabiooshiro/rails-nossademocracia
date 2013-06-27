class User < ActiveRecord::Base
	acts_as_nested_set
	belongs_to :representante, :foreign_key => "parent_id", :class_name => "User"
end
