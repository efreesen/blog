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

ActiveRecord::Schema.define(version: 2) do

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,     null: false
    t.string   "slug",         limit: 255,   null: false
    t.string   "title",        limit: 255,   null: false
    t.string   "subtitle",     limit: 255
    t.text     "content",      limit: 65535
    t.boolean  "published",    limit: 1
    t.date     "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree
  add_index "posts", ["user_id"], name: "fk_rails_f2f7d59426", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.string   "page",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "posts", "users"
end
