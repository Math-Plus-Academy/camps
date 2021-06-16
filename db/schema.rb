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

ActiveRecord::Schema.define(version: 20210616151213) do

  create_table "camp_interests", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.integer  "year"
    t.boolean  "newsletter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "camp_offerings", force: :cascade do |t|
    t.integer  "camp_id"
    t.string   "teacher",       limit: 255
    t.string   "assistant",     limit: 255
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "location_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "offering_time", limit: 255
    t.integer  "classroom"
    t.integer  "week"
    t.string   "time",          limit: 255
    t.boolean  "hidden"
    t.integer  "year"
    t.boolean  "extended_care",             default: false
    t.string   "zoom_link"
  end

  create_table "camp_offerings_registrations", id: false, force: :cascade do |t|
    t.integer "camp_offering_id", null: false
    t.integer "registration_id",  null: false
  end

  add_index "camp_offerings_registrations", ["camp_offering_id", "registration_id"], name: "camp_off_reg", unique: true

  create_table "camp_surveys", force: :cascade do |t|
    t.text     "comment"
    t.text     "improvements"
    t.string   "parent_first_name", limit: 255
    t.string   "parent_last_name",  limit: 255
    t.string   "student_name",      limit: 255
    t.string   "grade_completed",   limit: 255
    t.string   "phone",             limit: 255
    t.string   "email",             limit: 255
    t.time     "contact_time"
    t.string   "preferred_contact", limit: 255
    t.boolean  "contact_fall"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "satisfaction"
    t.integer  "camp_id"
    t.integer  "location_id"
    t.boolean  "contacted",                     default: false
  end

  create_table "camp_surveys_weekly_programs", id: false, force: :cascade do |t|
    t.integer "camp_survey_id",    null: false
    t.integer "weekly_program_id", null: false
  end

  add_index "camp_surveys_weekly_programs", ["camp_survey_id", "weekly_program_id"], name: "samp_survery_prog"

  create_table "camps", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.text     "description"
    t.integer  "capacity"
    t.string   "age",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
    t.text     "show_description"
    t.boolean  "girls_only",                   default: false
    t.text     "video_url"
    t.boolean  "online"
    t.boolean  "active",                       default: false
    t.string   "parent_webpage"
  end

  create_table "coupon_codes", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "description"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coupon_type",       limit: 255
    t.boolean  "active"
    t.string   "image_uid",         limit: 255, default: ""
    t.integer  "half_day_discount",             default: 0
    t.integer  "full_day_discount",             default: 0
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "registration_id"
    t.boolean  "paid",                           default: false
    t.date     "payment_date"
    t.string   "stripe_charge_id",   limit: 255
    t.string   "stripe_customer_id", limit: 255
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attempts",                       default: 0
    t.boolean  "payment_declined",               default: false
    t.date     "due_date"
    t.integer  "payment_order"
    t.string   "charge_description", limit: 255
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "address_1",  limit: 255
    t.string   "address_2",  limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.integer  "zip"
    t.string   "telephone",  limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "directions"
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "parent_first_name",       limit: 255
    t.string   "parent_last_name",        limit: 255
    t.string   "parent_address_1",        limit: 255
    t.string   "parent_address_2",        limit: 255
    t.string   "parent_email",            limit: 255
    t.string   "parent_phone",            limit: 255
    t.string   "student_first_name",      limit: 255
    t.string   "student_last_name",       limit: 255
    t.string   "student_grade",           limit: 255
    t.string   "student_allergies",       limit: 255
    t.string   "emergency_contact_name",  limit: 255
    t.string   "emergency_contact_phone", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_token",   limit: 255
    t.string   "stripe_charge_token",     limit: 255
    t.integer  "total"
    t.string   "parent_city",             limit: 255
    t.string   "parent_state",            limit: 255
    t.integer  "parent_zip"
    t.integer  "location_id"
    t.string   "coupon_code",             limit: 255
    t.boolean  "camp_campaign",                       default: false
    t.integer  "year"
    t.boolean  "newsletter",                          default: false
    t.string   "coupon_uid",              limit: 255, default: ""
    t.boolean  "payment_plan",                        default: false
    t.string   "stripe_customer_id",      limit: 255
    t.boolean  "payment_plan_completed",              default: false
    t.string   "referred_by",             limit: 255
    t.integer  "infusionsoft_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.integer  "location_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "weekly_programs", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
