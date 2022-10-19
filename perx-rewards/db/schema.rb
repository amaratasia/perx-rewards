# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_19_071954) do

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "amount_su", default: 0
    t.json "meta", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "currency", default: "INR"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name", null: false
    t.string "format", null: false
    t.json "config", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_points", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "user_id", null: false
    t.integer "points", default: 0
    t.json "meta", default: {}
    t.integer "running_balance", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_user_points_on_order_id"
    t.index ["user_id"], name: "index_user_points_on_user_id"
  end

  create_table "user_rewards", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "reward_id", null: false
    t.boolean "status", default: true
    t.json "meta", default: {}
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reward_id"], name: "index_user_rewards_on_reward_id"
    t.index ["user_id"], name: "index_user_rewards_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.integer "points", default: 0
    t.datetime "dob"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "orders", "users"
  add_foreign_key "user_points", "orders"
  add_foreign_key "user_points", "users"
  add_foreign_key "user_rewards", "rewards"
  add_foreign_key "user_rewards", "users"
end