class RenameTimeZoneInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :timezone, :time_zone if column_exists? :users, :timezone
  end
end
