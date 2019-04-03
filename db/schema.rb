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

ActiveRecord::Schema.define(version: 59) do

  create_table "analyses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", default: true
    t.string "ancestry"
    t.index ["ancestry"], name: "index_analyses_on_ancestry"
  end

  create_table "analysis_disciplines", force: :cascade do |t|
    t.integer "discipline_id"
    t.integer "analysis_id"
    t.index ["analysis_id"], name: "index_analysis_disciplines_on_analysis_id"
    t.index ["discipline_id"], name: "index_analysis_disciplines_on_discipline_id"
  end

  create_table "attachments", force: :cascade do |t|
    t.string "container_type"
    t.integer "container_id"
    t.string "data_file_name"
    t.string "data_content_type"
    t.integer "data_file_size"
    t.datetime "data_updated_at"
    t.string "description"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["container_type", "container_id"], name: "index_attachments_on_container_type_and_container_id"
  end

  create_table "cases", force: :cascade do |t|
    t.integer "operation_id"
    t.integer "variable_id"
    t.integer "coord_index", default: -1
    t.text "values"
  end

  create_table "connections", force: :cascade do |t|
    t.integer "from_id"
    t.integer "to_id"
    t.string "role", default: ""
    t.index ["from_id"], name: "index_connections_on_from_id"
    t.index ["to_id"], name: "index_connections_on_to_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "name"
    t.integer "analysis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "position"
    t.index ["analysis_id"], name: "index_disciplines_on_analysis_id"
  end

  create_table "geometry_models", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "status"
    t.text "log", default: "\"\\\"\\\\\\\"\\\\\\\\\\\\\\\"\\\\\\\\\\\\\\\"\\\\\\\"\\\"\""
    t.integer "pid", default: -1
    t.integer "operation_id"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.string "sqlite_filename"
    t.integer "log_count", default: 0
  end

  create_table "notebooks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "openmdao_analysis_impls", force: :cascade do |t|
    t.boolean "parallel_group"
    t.integer "analysis_id"
    t.integer "nonlinear_solver_id"
    t.integer "linear_solver_id"
    t.index ["analysis_id"], name: "index_openmdao_analysis_impls_on_analysis_id"
    t.index ["linear_solver_id"], name: "index_openmdao_analysis_impls_on_linear_solver_id"
    t.index ["nonlinear_solver_id"], name: "index_openmdao_analysis_impls_on_nonlinear_solver_id"
  end

  create_table "openmdao_discipline_impls", force: :cascade do |t|
    t.boolean "implicit_component"
    t.boolean "support_partial_derivatives"
    t.integer "discipline_id"
    t.index ["discipline_id"], name: "index_openmdao_discipline_impls_on_discipline_id"
  end

  create_table "operations", force: :cascade do |t|
    t.integer "analysis_id"
    t.string "name"
    t.string "host", default: ""
    t.string "driver", default: "runonce"
    t.text "success"
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.integer "operation_id"
    t.index ["operation_id"], name: "index_options_on_operation_id"
  end

  create_table "parameters", force: :cascade do |t|
    t.text "init", default: ""
    t.text "lower", default: ""
    t.text "upper", default: ""
    t.integer "variable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "solvers", force: :cascade do |t|
    t.string "name"
    t.float "atol"
    t.float "rtol"
    t.integer "maxiter"
    t.integer "iprint"
    t.boolean "err_on_maxiter"
  end

  create_table "users", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "api_key"
    t.text "settings"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "variables", force: :cascade do |t|
    t.string "name"
    t.integer "discipline_id"
    t.string "io_mode"
    t.string "type"
    t.string "shape"
    t.string "units"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
  end

end
