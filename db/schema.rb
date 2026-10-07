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

ActiveRecord::Schema[7.2].define(version: 2026_10_03_093001) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "start_date_time", null: false
    t.datetime "end_date_time", null: false
    t.integer "status", default: 0, null: false
    t.bigint "guest_id", null: false
    t.bigint "nutritionist_service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id", "status"], name: "index_appointments_on_guest_id_and_status"
    t.index ["guest_id"], name: "index_appointments_on_guest_id"
    t.index ["nutritionist_service_id", "status", "start_date_time", "end_date_time"], name: "idx_on_nutritionist_service_id_status_start_date_ti_b9af78d037"
    t.index ["nutritionist_service_id"], name: "index_appointments_on_nutritionist_service_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutritionist_services", force: :cascade do |t|
    t.bigint "nutritionist_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nutritionist_id", "service_id"], name: "index_nutritionist_services_on_nutritionist_id_and_service_id", unique: true
    t.index ["nutritionist_id"], name: "index_nutritionist_services_on_nutritionist_id"
    t.index ["service_id"], name: "index_nutritionist_services_on_service_id"
  end

  create_table "nutritionists", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "price", precision: 10, scale: 2, null: false
    t.integer "duration_in_minutes", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id"
    t.index ["location_id"], name: "index_services_on_location_id"
  end

  add_foreign_key "appointments", "guests"
  add_foreign_key "appointments", "nutritionist_services"
  add_foreign_key "nutritionist_services", "nutritionists"
  add_foreign_key "nutritionist_services", "services"
  add_foreign_key "services", "locations"
end
