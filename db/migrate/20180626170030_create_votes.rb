class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.boolean :vote
      t.string :voteable
      t.integer :user_id, :voteable_id
      t.timestamps
      # t.references :voteable, polymorphic: true
    end
  end
end
