class Comment < ActiveRecord::Base
  belongs_to :article, :user
  validates :body, presence: true
end
