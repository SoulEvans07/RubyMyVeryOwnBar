class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.bigint :sender
      t.bigint :item
      t.integer :item_type
      t.boolean :seen

      t.timestamps
    end
  end
end
