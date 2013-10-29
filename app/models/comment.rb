class Comment < ActiveRecord::Base
  attr_accessible :body, :parent_id
  belongs_to :article
  belongs_to :user
  validates :body, presence: true
  attr_accessible :article_id, :user_id
end
