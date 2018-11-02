class CreateUsersAndCocktailsAndIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false

      t.timestamps
    end

    create_table :cocktails do |t|
      t.string :name, null: false
      t.string :img, null: false, default: "/imgs/glass.jpg"
      t.text :description
      t.text :recipe

      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name, null: false
      t.string :img, null: false, default: "/imgs/ingredient.jpeg"
      t.text :description
      t.boolean :have, null: false, default: false

      t.timestamps
    end

    create_table :cocktails_ingredients, id: false do |t|
      t.belongs_to :cocktail, index: true
      t.belongs_to :ingredient, index: true
    end

    create_table :cocktails_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :cocktail, index: true
    end

    create_table :ingredients_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :ingredient, index: true
    end
  end
end
