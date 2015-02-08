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

ActiveRecord::Schema.define(version: 20150208031327) do

  create_table "images", force: true do |t|
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_file_name"
    t.string   "original_content_type"
    t.integer  "original_file_size"
    t.datetime "original_updated_at"
    t.string   "watermarked_file_name"
    t.string   "watermarked_content_type"
    t.integer  "watermarked_file_size"
    t.datetime "watermarked_updated_at"
    t.integer  "job_id"
    t.integer  "metadata_id"
  end

  create_table "jobs", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "school"
    t.integer  "class_year"
  end

  create_table "metadata", force: true do |t|
    t.string   "facebook"
    t.string   "linkedin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
