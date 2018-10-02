class CreateCocktails < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :img
      t.string :description
      t.string :recipe

      t.timestamps
    end
  end
end
