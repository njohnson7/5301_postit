class Post < ActiveRecord::Base
  include Voteable

  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many   :comments
  has_many   :post_categories
  has_many   :categories, through: :post_categories


  validates :title,       presence: true, length: { minimum: 3 }
  validates :url,         presence: true  #, uniqueness: true
  validates :description, presence: true

  before_save :slugify

  def slugify
    slug = self.title.strip.downcase.gsub(/[^a-z0-9]/i, '-').gsub(/-+/, '-')
    while Post.find_by(slug: slug)
      slug = slug =~ /\d+\z/ ? slug.sub(/\d+\z/) { |n| (n.to_i + 1).to_s } : slug + '-2'
    end
    self.slug = slug
  end

  def to_param
    self.slug
  end
end
