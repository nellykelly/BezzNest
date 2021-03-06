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

ActiveRecord::Schema.define(version: 20160719214523) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "content"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
  end

  add_index "friendships", ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true
  add_index "friendships", ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.boolean  "viewed"
    t.integer  "topic_id"
    t.string   "contents"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.integer  "post_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["post_id"], name: "index_photos_on_post_id"

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "password_digest"
    t.float    "salt"
    t.string   "company_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "location"
    t.string   "company_type"
    t.integer  "size_catagory"
    t.integer  "prices"
    t.integer  "year_founded"
  end

end
