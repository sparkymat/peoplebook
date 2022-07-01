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

ActiveRecord::Schema[7.0].define(version: 2022_07_01_132308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "child_relations", force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "partnership_id"
    t.integer "relation_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["child_id"], name: "index_child_relations_on_child_id"
    t.index ["partnership_id"], name: "index_child_relations_on_partnership_id"
  end

  create_table "partnerships", force: :cascade do |t|
    t.bigint "person1_id"
    t.bigint "person2_id"
    t.date "started_at"
    t.date "ended_at"
    t.integer "started_at_resolution", default: 0, null: false
    t.integer "ended_at_resolution", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person1_id"], name: "index_partnerships_on_person1_id"
    t.index ["person2_id"], name: "index_partnerships_on_person2_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "other_names", default: [], array: true
    t.string "gender", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_people_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "child_relations", "people", column: "child_id"
  add_foreign_key "partnerships", "people", column: "person1_id"
  add_foreign_key "partnerships", "people", column: "person2_id"
end
