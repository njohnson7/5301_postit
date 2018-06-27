class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string unless column_exists? :users, :role
  end
end
