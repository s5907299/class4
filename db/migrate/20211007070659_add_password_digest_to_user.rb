class AddPasswordDigestToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :password_digest, :string
    remove_column :users, :passwordDigest, :string
  end
end
