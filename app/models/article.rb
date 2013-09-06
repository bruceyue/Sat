class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :taggings
  has_many :tags, through: :taggings
  validates :title, :body, presence: true
  validates :title, length: { :minimum => 5 }
end
