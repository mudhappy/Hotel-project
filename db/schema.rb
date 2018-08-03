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

ActiveRecord::Schema.define(version: 20180802000546) do

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
    t.string "ruc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locals", force: :cascade do |t|
    t.integer "enterprise_id"
    t.integer "stars"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enterprise_id"], name: "index_locals_on_enterprise_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.decimal "recommended_price"
    t.decimal "sale_price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "rooms_type_id"
    t.integer "rooms_state_id"
    t.decimal "price"
    t.string "dni"
    t.integer "roomer_quantities"
    t.datetime "left_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enterprise_id"
    t.index ["enterprise_id"], name: "index_rooms_on_enterprise_id"
    t.index ["rooms_state_id"], name: "index_rooms_on_rooms_state_id"
    t.index ["rooms_type_id"], name: "index_rooms_on_rooms_type_id"
  end

  create_table "rooms_states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enterprise_id"
    t.index ["enterprise_id"], name: "index_rooms_states_on_enterprise_id"
  end

  create_table "rooms_types", force: :cascade do |t|
    t.string "name"
    t.integer "bed_cuantities"
    t.decimal "recommended_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enterprise_id"
    t.index ["enterprise_id"], name: "index_rooms_types_on_enterprise_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "enterprise_id"
    t.string "authentication_token", limit: 30
    t.integer "role"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["enterprise_id"], name: "index_users_on_enterprise_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
