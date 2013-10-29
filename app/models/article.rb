class Article < ActiveRecord::Base
  attr_accessible :tag_ids, :comment_ids, :user_id
  attr_accessible :body, :subject, :is_published, :picture, :comments_count, :tag_list
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :taggings
  has_many :tags, through: :taggings
  validates :subject, :body, presence: true
  validates :subject, length: { :minimum => 5 }
  scope :created_at, -> { where('created_at <= ?', Time.now.utc) }
  mount_uploader :picture, PictureUploader

  def self.tagged_with(name)
    Tag.find_by_name!(name).articles
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id, tags.id, tags.name")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      #Tag.where(name: n.strip).first_or_create!
      Tag.find_or_create_by_name(n.strip)
    end
  end

  def self.search_published(query, tag_id = nil)
    created_at.primitive_search(query)
  end

  def self.primitive_search(query, join = "AND")
    where(primitive_search_conditions(query, join))
  end

  def self.primitive_search_conditions(query, join)
    query.split(/\s+/).map do |word|
      '(' + %w[subject body ].map { |col| "#{col} LIKE #{sanitize('%' + word.to_s + '%')}" }.join(' OR ') + ')'
    end.join(" #{join} ")
  end

  # format url
  #Removes all non alphanumeric characters from the string.
  #No more than one of the separator in a row.
  #Remove leading/trailing separator.
  def to_param
    "#{id}-#{subject.downcase.gsub(/[^a-zA-Z0-9]+/, '-').gsub(/-{2,}/, '-').gsub(/^-|-$/, '')}"
  end
end
