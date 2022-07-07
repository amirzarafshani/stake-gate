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

ActiveRecord::Schema[7.0].define(version: 2022_07_05_161102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plans", force: :cascade do |t|
    t.integer "days"
    t.string "name"
    t.float "profit"
    t.float "penalty"
    t.integer "plan_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_depost"
  end

  create_table "referral_rates", force: :cascade do |t|
    t.integer "referral_count"
    t.float "profit_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_transactions", force: :cascade do |t|
    t.decimal "amount"
    t.integer "action"
    t.integer "status"
    t.bigint "plan_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_user_transactions_on_plan_id"
    t.index ["user_id"], name: "index_user_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "referrer_id"
    t.string "referral_code"
  end

  add_foreign_key "user_transactions", "plans"
  add_foreign_key "user_transactions", "users"
end
