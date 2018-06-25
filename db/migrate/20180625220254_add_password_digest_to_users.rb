class AddPasswordDigestToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :password_digest, :string) unless column_exists?(:users, :password_digest)
  end
end
