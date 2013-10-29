class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  attr_accessible :post_id, :user_id
end
