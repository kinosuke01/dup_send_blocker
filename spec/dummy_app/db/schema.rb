# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20201006085900) do

  create_table "dup_send_blocker_send_logs", force: :cascade do |t|
    t.string   "label01",       limit: 255, default: "", null: false
    t.string   "label02",       limit: 255, default: "", null: false
    t.string   "label03",       limit: 255, default: "", null: false
    t.string   "error_message", limit: 255
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "dup_send_blocker_send_logs", ["label01", "label02", "label03"], name: "index_dup_send_blocker_send_logs_on_label01__03", unique: true, using: :btree
  add_index "dup_send_blocker_send_logs", ["label01", "label02"], name: "index_dup_send_blocker_send_logs_on_label01__02", using: :btree
  add_index "dup_send_blocker_send_logs", ["label01"], name: "index_dup_send_blocker_send_logs_on_label01", using: :btree

end
