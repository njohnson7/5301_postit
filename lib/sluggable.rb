module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :slugify
  end

  def slugify
    slug = self.send(self.class.const_get(:SLUG_ATTR))
    slug = slug.strip.downcase.gsub(/[^a-z0-9]/i, '-').gsub(/-+/, '-')
    while Post.find_by(slug: slug)
      slug = slug =~ /\d+\z/ ? slug.sub(/\d+\z/) { |n| (n.to_i + 1).to_s } : slug + '-2'
    end
    self.slug = slug
  end

  def to_param
    self.slug
  end
end
