# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_11_01_203947) do

  create_table "cocktails", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "img", default: "/imgs/glass.jpg", null: false
    t.text "description"
    t.text "recipe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_cocktails_on_user_id"
  end

  create_table "cocktails_ingredients", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "cocktail_id"
    t.bigint "ingredient_id"
    t.index ["cocktail_id"], name: "index_cocktails_ingredients_on_cocktail_id"
    t.index ["ingredient_id"], name: "index_cocktails_ingredients_on_ingredient_id"
  end

  create_table "cocktails_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "cocktail_id"
    t.index ["cocktail_id"], name: "index_cocktails_users_on_cocktail_id"
    t.index ["user_id"], name: "index_cocktails_users_on_user_id"
  end

  create_table "ingredients", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "img", default: "/imgs/ingredient.jpeg", null: false
    t.text "description"
    t.boolean "have", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_ingredients_on_user_id"
  end

  create_table "ingredients_users", id: false, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ingredient_id"
    t.index ["ingredient_id"], name: "index_ingredients_users_on_ingredient_id"
    t.index ["user_id"], name: "index_ingredients_users_on_user_id"
  end

  create_table "notifications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "sender", null: false
    t.bigint "item", null: false
    t.integer "item_type", null: false
    t.boolean "seen", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "salt"
    t.string "img", default: "/imgs/user.png", null: false
  end

  add_foreign_key "cocktails", "users"
  add_foreign_key "ingredients", "users"
  add_foreign_key "notifications", "users"
end
