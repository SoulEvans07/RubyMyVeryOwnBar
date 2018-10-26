class AddSaltToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :salt, :string
    rename_column :users, :password, :encrypted_password
  end

  def down
    remove_column :users, :salt
    rename_column :users, :encrypted_password, :password
  end
end
