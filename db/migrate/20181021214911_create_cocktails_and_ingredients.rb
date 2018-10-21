class CreateCocktailsAndIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.string :img
      t.string :description
      t.string :recipe

      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name
      t.string :img
      t.string :description
      t.boolean :have

      t.timestamps
    end

    create_table :cocktails_ingredients, id: false do |t|
      t.belongs_to :cocktail, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end