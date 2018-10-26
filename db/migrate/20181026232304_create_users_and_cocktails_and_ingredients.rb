class CreateUsersAndCocktailsAndIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end

    create_table :cocktails do |t|
      t.string :name
      t.text :img
      t.text :description
      t.string :recipe

      t.timestamps
    end

    create_table :ingredients do |t|
      t.string :name
      t.text :img
      t.text :description
      t.boolean :have

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
  end
end
