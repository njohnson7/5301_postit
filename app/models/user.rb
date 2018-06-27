class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  before_save :slugify

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create

  def slugify
    self.slug = self.username.downcase.gsub(' ', '-').gsub(/[^a-z0-9-]/, '')
  end

  def to_param
    self.slug
  end
end
