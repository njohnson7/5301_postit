class MakeUserIdAForeignKey2 < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer, foreign_key: true
  end
end
