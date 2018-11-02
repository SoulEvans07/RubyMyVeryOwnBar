class AddImgToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :img, :string, null: false, default: '/imgs/user.png'
  end

  def down
    remove_column :users, :img, :string
  end
end
