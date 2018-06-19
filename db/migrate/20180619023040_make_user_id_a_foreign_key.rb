class MakeUserIdAForeignKey < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.remove(:user_id)
    end
  end
end
