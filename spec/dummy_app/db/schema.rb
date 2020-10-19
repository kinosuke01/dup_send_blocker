# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_06_085900) do

  create_table "dup_send_blocker_send_logs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "label01", default: "", null: false
    t.string "label02", default: "", null: false
    t.string "label03", default: "", null: false
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label01", "label02", "label03"], name: "index_dup_send_blocker_send_logs_on_label01__03", unique: true
    t.index ["label01", "label02"], name: "index_dup_send_blocker_send_logs_on_label01__02"
    t.index ["label01"], name: "index_dup_send_blocker_send_logs_on_label01"
  end

end
