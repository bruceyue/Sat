class Site < ActiveRecord::Base
	attr_accessible :name, :link, :stype, :description, :is_active
end
