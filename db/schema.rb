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

ActiveRecord::Schema.define(version: 20170404143752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "subdomain_name"
    t.integer  "owner_id"
    t.integer  "plan_id"
    t.string   "updated_by"
    t.boolean  "del_flag"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "company_masters", force: :cascade do |t|
    t.string   "company_id"
    t.string   "company_name"
    t.string   "company_short_name"
    t.string   "company_owner_name"
    t.string   "company_owner_email"
    t.string   "encrypted_company_pan_no"
    t.string   "encrypted_company_pan_no_iv"
    t.string   "company_establish_dt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "del_flag",                    default: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "gstins", force: :cascade do |t|
    t.integer  "company_master_id"
    t.string   "gstin_no"
    t.string   "created_by"
    t.string   "updated_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.boolean  "del_flag",          default: false
  end

  add_index "gstins", ["company_master_id"], name: "index_gstins_on_company_master_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "created_by"
    t.string   "updated_by"
    t.boolean  "del_flag",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "payments", ["account_id"], name: "index_payments_on_account_id", using: :btree

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.integer  "users"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscribes", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "stripe_customer_id"
    t.integer  "plan_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "subscribes", ["user_id"], name: "index_subscribes_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.boolean  "is_admin",               default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "is_user_active",         default: true
    t.datetime "password_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "updated_by"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "stripe_customer_id"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
