class RemoveUrlAndDescriptionFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :url
    remove_column :users, :description
  end
end
