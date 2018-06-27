class AddSlugToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string unless column_exists? :users, :slug
  end
end
