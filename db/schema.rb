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

ActiveRecord::Schema.define(version: 20140729150242) do

  create_table "amends", force: true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_files", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "funders", force: true do |t|
    t.integer  "user_id"
    t.integer  "perk_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "galleries", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "image_url"
    t.integer  "galery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "perks", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.date     "delivery_date"
    t.decimal  "price"
    t.integer  "pieces"
    t.integer  "project_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.decimal  "monetary_goal"
    t.date     "init_date"
    t.date     "finish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "image_id"
  end

  create_table "rols", force: true do |t|
    t.string   "rol_name"
    t.boolean  "admin"
    t.boolean  "module_1"
    t.boolean  "module_2"
    t.boolean  "module_3"
    t.boolean  "module_4"
    t.boolean  "module_5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "rol_id"
  end

  create_table "videos", force: true do |t|
    t.string   "video_url"
    t.integer  "galery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
