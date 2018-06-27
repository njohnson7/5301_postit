module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :slugify
    class_attribute :slug_column
  end

  def slugify
    slug = self.send(self.class.slug_column)
    slug = slug.strip.downcase.gsub(/[^a-z0-9]/i, '-').gsub(/-+/, '-')
    while self.class.find_by(slug: slug)
      slug = slug =~ /\d+\z/ ? slug.sub(/\d+\z/) { |n| (n.to_i + 1).to_s } : slug + '-2'
    end
    self.slug = slug
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column col_name
      self.slug_column = col_name
    end
  end
end
