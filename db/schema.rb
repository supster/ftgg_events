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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130809184034) do

  create_table "ev_favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ev_favorites", ["event_id"], :name => "index_ev_favorites_on_event_id"
  add_index "ev_favorites", ["user_id"], :name => "index_ev_favorites_on_user_id"

  create_table "event_brites", :force => true do |t|
    t.string   "eb_id"
    t.string   "name"
    t.text     "description"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "url"
    t.string   "location"
    t.string   "address"
    t.float    "cost"
    t.boolean  "archieve"
    t.boolean  "display"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_date_time"
    t.datetime "end_date_time"
    t.string   "location"
    t.string   "address"
    t.float    "cost"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "url"
    t.string   "time_zone"
    t.string   "benefits"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "password_digest"
    t.boolean  "admin",           :default => false
    t.string   "remember_token"
  end

  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
