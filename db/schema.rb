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

ActiveRecord::Schema.define(version: 2018_09_20_015351) do

  create_table "bus_line_main_streets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "bus_line_id", null: false
    t.bigint "main_street_id", null: false
    t.index ["bus_line_id", "main_street_id"], name: "index_bus_line_main_streets_on_bus_line_id_and_main_street_id"
    t.index ["bus_line_id"], name: "index_bus_line_main_streets_on_bus_line_id"
    t.index ["main_street_id"], name: "index_bus_line_main_streets_on_main_street_id"
  end

  create_table "bus_lines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
  end

  create_table "main_streets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "city"
  end

end
