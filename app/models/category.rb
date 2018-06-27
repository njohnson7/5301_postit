class Category < ActiveRecord::Base
  SLUG_ATTR = :name

  include Sluggable

  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true
end
