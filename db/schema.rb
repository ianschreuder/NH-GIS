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

ActiveRecord::Schema.define(:version => 20101204210834) do

  create_table "complaint_deficiencies", :force => true do |t|
    t.integer  "home_id"
    t.integer  "survey_id"
    t.string   "provider_number",    :limit => 20
    t.datetime "survey_date"
    t.datetime "date_of_correction"
    t.string   "severity"
    t.string   "deficiency_type"
    t.string   "category_code"
    t.string   "category_desc"
    t.string   "deficiency"
    t.string   "scope"
    t.string   "level_of_harm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "complaint_deficiencies", ["home_id"], :name => "idx_c_deficiencies_homes"
  add_index "complaint_deficiencies", ["survey_date"], :name => "idx_c_deficiencies_date"
  add_index "complaint_deficiencies", ["survey_id"], :name => "idx_c_deficiencies_surveys"

  create_table "deficiencies", :force => true do |t|
    t.integer  "home_id"
    t.integer  "survey_id"
    t.string   "provider_number",    :limit => 20
    t.datetime "survey_date"
    t.datetime "date_of_correction"
    t.string   "severity"
    t.string   "deficiency_type"
    t.string   "category_code"
    t.string   "category_desc"
    t.string   "deficiency"
    t.string   "scope"
    t.string   "level_of_harm"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "deficiencies", ["home_id"], :name => "idx_deficiencies_homes"
  add_index "deficiencies", ["survey_date"], :name => "idx_deficiencies_date"
  add_index "deficiencies", ["survey_id"], :name => "idx_deficiencies_surveys"

  create_table "homes", :force => true do |t|
    t.integer  "facility_id"
    t.string   "provider_number"
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.integer  "num_beds"
    t.integer  "num_residents"
    t.string   "category"
    t.string   "type_owner"
    t.integer  "in_hospital"
    t.integer  "multiple_ownership"
    t.string   "councils"
    t.integer  "ccrc"
    t.integer  "qis_home"
    t.integer  "sff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.integer  "home_id"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "home_id"
    t.string   "provider_number"
    t.datetime "survey_date"
    t.integer  "qis"
  end

  add_index "surveys", ["home_id"], :name => "idx_surveys_homes"
  add_index "surveys", ["survey_date"], :name => "idx_surveys_dates"

end
