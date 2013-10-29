class Book < ActiveRecord::Base
  belongs_to :user
  attr_accessible :contributor, :name, :btype, :publication_date
end
