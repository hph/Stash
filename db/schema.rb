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

ActiveRecord::Schema.define(version: 20141101004230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", force: true do |t|
    t.integer  "user_id",                    null: false
    t.string   "uid",                        null: false
    t.string   "url",                        null: false
    t.string   "name",                       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public",     default: false, null: false
    t.integer  "visits",     default: 0,     null: false
    t.string   "category"
  end

  add_index "links", ["uid"], name: "index_links_on_uid", unique: true, using: :btree
  add_index "links", ["user_id"], name: "index_links_on_user_id", using: :btree

  create_table "links_tags", id: false, force: true do |t|
    t.integer "tag_id",  null: false
    t.integer "link_id", null: false
  end

  add_index "links_tags", ["tag_id", "link_id"], name: "index_links_tags_on_tag_id_and_link_id", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "trackings", force: true do |t|
    t.integer  "user_id"
    t.integer  "link_id",    null: false
    t.inet     "ip"
    t.datetime "created_at"
  end

  add_index "trackings", ["link_id"], name: "index_trackings_on_link_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "links", "users", name: "links_user_id_fk", dependent: :delete

  add_foreign_key "links_tags", "links", name: "links_tags_link_id_fk", dependent: :delete
  add_foreign_key "links_tags", "tags", name: "links_tags_tag_id_fk", dependent: :delete

  add_foreign_key "trackings", "links", name: "trackings_link_id_fk", dependent: :delete
  add_foreign_key "trackings", "users", name: "trackings_user_id_fk", dependent: :delete

end
