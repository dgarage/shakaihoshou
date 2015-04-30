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

ActiveRecord::Schema.define(version: 20150430072917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comparisons", force: true do |t|
    t.integer  "column_1"
    t.string   "column_2"
    t.integer  "column_3"
    t.string   "column_4"
    t.string   "column_5"
    t.string   "block_1_1"
    t.float    "block_1_2"
    t.float    "block_1_3"
    t.float    "block_1_4"
    t.string   "block_2_1"
    t.float    "block_2_2"
    t.float    "block_2_3"
    t.float    "block_2_4"
    t.string   "block_3_1"
    t.float    "block_3_2"
    t.float    "block_3_3"
    t.float    "block_3_4"
    t.string   "block_4_1"
    t.float    "block_4_2"
    t.float    "block_4_3"
    t.float    "block_4_4"
    t.string   "block_5_1"
    t.float    "block_5_2"
    t.float    "block_5_3"
    t.float    "block_5_4"
    t.string   "block_6_1"
    t.float    "block_6_2"
    t.float    "block_6_3"
    t.float    "block_6_4"
    t.integer  "endcolumn_1"
    t.float    "endcolumn_2"
    t.string   "endcolumn_3"
    t.string   "endcolumn_4"
    t.float    "extracolumn_1"
    t.float    "extracolumn_2"
    t.float    "extracolumn_3"
    t.float    "extracolumn_4"
    t.float    "extracolumn_5"
    t.float    "extracolumn_6"
    t.float    "extracolumn_7"
    t.float    "extracolumn_8"
    t.float    "extracolumn_9"
    t.float    "extracolumn_10"
    t.float    "extracolumn_11"
    t.float    "extracolumn_12"
    t.float    "extracolumn_13"
    t.float    "extracolumn_14"
    t.float    "extracolumn_15"
    t.float    "extracolumn_16"
    t.float    "extracolumn_17"
    t.float    "extracolumn_18"
    t.float    "extracolumn_19"
    t.float    "extracolumn_20"
    t.float    "extracolumn_21"
    t.text     "last_column"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "incidents", force: true do |t|
    t.text "0"
    t.text "1"
    t.text "2"
    t.text "3"
    t.text "4"
    t.text "5"
    t.text "6"
    t.text "7"
    t.text "8"
    t.text "9"
    t.text "10"
    t.text "11"
    t.text "12"
    t.text "13"
    t.text "14"
    t.text "15"
    t.text "16"
    t.text "17"
    t.text "18"
    t.text "19"
    t.text "20"
    t.text "21"
    t.text "22"
    t.text "23"
    t.text "24"
    t.text "25"
    t.text "26"
    t.text "27"
    t.text "28"
    t.text "29"
    t.text "30"
    t.text "31"
    t.text "32"
    t.text "33"
    t.text "34"
    t.text "35"
  end

end
