class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true, null: false
      t.bigint :sender, null: false
      t.bigint :item, null: false
      t.integer :item_type, null: false
      t.boolean :seen, null: false, default: false

      t.timestamps
    end
  end
end
