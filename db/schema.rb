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

ActiveRecord::Schema.define(version: 2019_06_19_003913) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "equipments", force: :cascade do |t|
    t.integer "spoon_id"
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.integer "spoon_id"
    t.float "metric_amount"
    t.string "metric_unit"
    t.float "us_amount"
    t.string "us_unit"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "orig_string"
  end

  create_table "recipe_equipments", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "equipment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "spoon_id"
    t.string "title"
    t.string "image_url"
    t.integer "ready_in_minutes"
    t.boolean "is_vegetarian"
    t.boolean "is_vegan"
    t.string "source_name"
    t.integer "likes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "cuisines", default: [], array: true
    t.integer "servings"
    t.string "dish_types", default: [], array: true
    t.string "source_url"
  end

  create_table "step_equipments", force: :cascade do |t|
    t.integer "step_id"
    t.integer "equipment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "step_ingredients", force: :cascade do |t|
    t.integer "step_id"
    t.integer "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "steps", force: :cascade do |t|
    t.integer "recipe_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "step_no"
    t.string "spoon_ids", default: [], array: true
    t.string "equipment_ids", default: [], array: true
  end

end
