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

ActiveRecord::Schema.define(version: 20160725043703) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.text     "message"
    t.integer  "grammer_id"
    t.integer  "gram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["gram_id"], name: "index_comments_on_gram_id", using: :btree
  add_index "comments", ["grammer_id"], name: "index_comments_on_grammer_id", using: :btree

  create_table "grammers", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "grammers", ["email"], name: "index_grammers_on_email", unique: true, using: :btree
  add_index "grammers", ["reset_password_token"], name: "index_grammers_on_reset_password_token", unique: true, using: :btree

  create_table "grams", force: true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grammer_id"
    t.string   "picture"
  end

  add_index "grams", ["grammer_id"], name: "index_grams_on_grammer_id", using: :btree

end
