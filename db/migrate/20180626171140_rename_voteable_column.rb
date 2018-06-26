class RenameVoteableColumn < ActiveRecord::Migration
  def change
    rename_column :votes, :voteable, :voteable_type
  end
end
