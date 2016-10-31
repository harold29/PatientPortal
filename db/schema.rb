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

ActiveRecord::Schema.define(version: 20161020171304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "location"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "country_id"
    t.integer  "state_id"
    t.integer  "municipality_id"
    t.index ["country_id"], name: "index_addresses_on_country_id", using: :btree
    t.index ["municipality_id"], name: "index_addresses_on_municipality_id", using: :btree
    t.index ["state_id"], name: "index_addresses_on_state_id", using: :btree
  end

  create_table "allergies", force: :cascade do |t|
    t.date     "init_date"
    t.string   "name"
    t.text     "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "patient_id"
    t.index ["patient_id"], name: "index_allergies_on_patient_id", using: :btree
  end

  create_table "appointments", force: :cascade do |t|
    t.boolean  "accepted"
    t.date     "appointment_date"
    t.boolean  "gcal_doc"
    t.boolean  "gcal_patient"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "service_id"
    t.integer  "patient_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id", using: :btree
    t.index ["service_id"], name: "index_appointments_on_service_id", using: :btree
  end

  create_table "clinics", force: :cascade do |t|
    t.string   "name"
    t.string   "mail"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone3"
    t.string   "phone4"
    t.string   "fax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "address_id"
    t.index ["address_id"], name: "index_clinics_on_address_id", using: :btree
  end

  create_table "countries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnoses", force: :cascade do |t|
    t.string   "name"
    t.string   "_cve_cie10"
    t.date     "diagnose_day"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "patient_id"
    t.integer  "doctor_id"
    t.index ["doctor_id"], name: "index_diagnoses_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_diagnoses_on_patient_id", using: :btree
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "professional_document"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "specialty_id"
    t.integer  "service_id"
    t.integer  "user_id"
    t.index ["service_id"], name: "index_doctors_on_service_id", using: :btree
    t.index ["specialty_id"], name: "index_doctors_on_specialty_id", using: :btree
    t.index ["user_id"], name: "index_doctors_on_user_id", using: :btree
  end

  create_table "medicines", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "frequency"
    t.string   "dose"
    t.string   "name"
    t.string   "way"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.index ["doctor_id"], name: "index_medicines_on_doctor_id", using: :btree
    t.index ["patient_id"], name: "index_medicines_on_patient_id", using: :btree
  end

  create_table "municipalities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "state_id"
    t.index ["state_id"], name: "index_municipalities_on_state_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "blood_type"
    t.string   "iee"
    t.string   "married"
    t.string   "studies"
    t.string   "case_file"
    t.string   "religion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "address_id"
    t.integer  "doctor_id"
    t.integer  "user_id"
    t.integer  "clinic_id"
    t.index ["address_id"], name: "index_patients_on_address_id", using: :btree
    t.index ["clinic_id"], name: "index_patients_on_clinic_id", using: :btree
    t.index ["doctor_id"], name: "index_patients_on_doctor_id", using: :btree
    t.index ["user_id"], name: "index_patients_on_user_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.datetime "birthday"
    t.integer  "zipcode"
    t.boolean  "approved"
    t.string   "role"
    t.integer  "age"
    t.string   "street"
    t.string   "colony"
    t.string   "gender"
    t.string   "msc_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.date     "day"
    t.time     "hour"
    t.boolean  "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "service_id"
    t.index ["service_id"], name: "index_schedules_on_service_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "clinic_id"
    t.index ["clinic_id"], name: "index_services_on_clinic_id", using: :btree
  end

  create_table "specialties", force: :cascade do |t|
    t.string   "name"
    t.boolean  "parent"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "specialty_id"
    t.index ["specialty_id"], name: "index_specialties_on_specialty_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "country_id"
    t.index ["country_id"], name: "index_states_on_country_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "gender"
    t.integer  "role"
    t.integer  "age"
    t.date     "birthday"
    t.string   "type"
    t.string   "access_token"
    t.string   "id_token"
    t.boolean  "disable"
    t.string   "verification_token"
    t.boolean  "validated"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "address_id"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "gmail_email"
    t.string   "uid"
    t.index ["address_id"], name: "index_users_on_address_id", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "addresses", "countries"
  add_foreign_key "addresses", "municipalities"
  add_foreign_key "addresses", "states"
  add_foreign_key "allergies", "patients"
  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "services"
  add_foreign_key "clinics", "addresses"
  add_foreign_key "diagnoses", "doctors"
  add_foreign_key "diagnoses", "patients"
  add_foreign_key "doctors", "services"
  add_foreign_key "doctors", "specialties"
  add_foreign_key "doctors", "users"
  add_foreign_key "medicines", "doctors"
  add_foreign_key "medicines", "patients"
  add_foreign_key "municipalities", "states"
  add_foreign_key "patients", "addresses"
  add_foreign_key "patients", "clinics"
  add_foreign_key "patients", "doctors"
  add_foreign_key "patients", "users"
  add_foreign_key "schedules", "services"
  add_foreign_key "services", "clinics"
  add_foreign_key "specialties", "specialties"
  add_foreign_key "states", "countries"
  add_foreign_key "users", "addresses"
end
