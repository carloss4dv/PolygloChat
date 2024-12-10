# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 0) do
  create_schema "postgis_topology"
  create_schema "tiger"
  create_schema "tiger_data"
  create_schema "topology"

  # These are extensions that must be enabled in order to support this database
  enable_extension "adminpack"
  enable_extension "autoinc"
  enable_extension "btree_gin"
  enable_extension "btree_gist"
  enable_extension "citext"
  enable_extension "cube"
  enable_extension "dblink"
  enable_extension "dict_int"
  enable_extension "dict_xsyn"
  enable_extension "earthdistance"
  enable_extension "file_fdw"
  enable_extension "fuzzystrmatch"
  enable_extension "hstore"
  enable_extension "insert_username"
  enable_extension "intagg"
  enable_extension "intarray"
  enable_extension "isn"
  enable_extension "lo"
  enable_extension "ltree"
  enable_extension "moddatetime"
  enable_extension "pageinspect"
  enable_extension "pg_buffercache"
  enable_extension "pg_freespacemap"
  enable_extension "pg_stat_statements"
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "pgrowlocks"
  enable_extension "pgstattuple"
  enable_extension "plpgsql"
  enable_extension "postgis"
  enable_extension "postgis_tiger_geocoder"
  enable_extension "refint"
  enable_extension "seg"
  enable_extension "sslinfo"
  enable_extension "tablefunc"
  enable_extension "tcn"
  enable_extension "timetravel"
  enable_extension "unaccent"
  enable_extension "uuid-ossp"
  enable_extension "xml2"

  create_table "community", primary_key: "name", id: { type: :string, limit: 30 }, force: :cascade do |t|
    t.string "country_name", limit: 50, null: false
    t.string "language_name", limit: 50, null: false
    t.string "rules", limit: 300
    t.string "descripcion", limit: 100
  end

  create_table "hablaWith", primary_key: ["community", "language_nam"], force: :cascade do |t|
    t.string "comunity_name", limit: 30, null: false
    t.string "language_name", limit: 50, null: false
  end

  create_table "hablaUser", primary_key: ["user_name", "language_name"], force: :cascade do |t|
    t.string "user_name", limit: 25, null: false
    t.string "language_name", limit: 50, null: false
  end

  create_table "language", primary_key: "name", id: { type: :string, limit: 50 }, force: :cascade do |t|
  end

  create_table "interestedLanguage", primary_key: ["user_name", "language_name"], force: :cascade do |t|
    t.string "use_name", limit: 25, null: false
    t.string "language_name", limit: 50, null: false
  end

  create_table "interesaCountry", primary_key: ["user_name", "country_name"], force: :cascade do |t|
    t.string "user_name", limit: 25, null: false
    t.string "country_name", limit: 50, null: false
  end

  create_table "message", id: :serial, force: :cascade do |t|
    t.string "user_name", limit: 25, null: false
    t.string "community_name", limit: 50, null: false
    t.string "text", limit: 400
    t.binary "immage"
    t.datetime "datetime", precision: nil
  end

  create_table "country", primary_key: "name", id: { type: :string, limit: 50 }, force: :cascade do |t|
  end

  create_table "participa", primary_key: ["user_name", "community_name"], force: :cascade do |t|
    t.string "user_name", limit: 25, null: false
    t.string "community_name", limit: 30, null: false
    t.string "moderator", limit: 1
    t.string "tags", limit: 1
  end

  create_table "spatial_ref_sys", primary_key: "srid", id: :integer, default: nil, force: :cascade do |t|
    t.string "auth_name", limit: 256
    t.integer "auth_srid"
    t.string "srtext", limit: 2048
    t.string "proj4text", limit: 2048
    t.check_constraint "srid > 0 AND srid <= 998999", name: "spatial_ref_sys_srid_check"
  end

  create_table "user", primary_key: "name", id: { type: :string, limit: 25 }, force: :cascade do |t|
    t.string "email", limit: 50
    t.string "password", limit: 50
    t.string "privileges", limit: 1
    t.binary "photo"
    t.string "country_name", limit: 50
    t.string "country_name", limit: 50
  end

  add_foreign_key "community", "idioma", column: "idioma", primary_key: "name", name: "community_idioma_fkey"
  add_foreign_key "community", "pais", column: "pais", primary_key: "name", name: "community_pais_fkey"
  add_foreign_key "hablacom", "community", column: "community", primary_key: "name", name: "hablacom_community_fkey", on_delete: :cascade
  add_foreign_key "hablacom", "idioma", column: "idioma", primary_key: "name", name: "hablacom_idioma_fkey", on_delete: :cascade
  add_foreign_key "hablausuario", "idioma", column: "idioma", primary_key: "name", name: "hablausuario_idioma_fkey", on_delete: :cascade
  add_foreign_key "hablausuario", "usuario", column: "usuario", primary_key: "name", name: "hablausuario_usuario_fkey", on_delete: :cascade
  add_foreign_key "interesaidioma", "idioma", column: "idioma", primary_key: "name", name: "interesaidioma_idioma_fkey", on_delete: :cascade
  add_foreign_key "interesaidioma", "usuario", column: "usuario", primary_key: "name", name: "interesaidioma_usuario_fkey", on_delete: :cascade
  add_foreign_key "interesapais", "pais", column: "pais", primary_key: "name", name: "interesapais_pais_fkey", on_delete: :cascade
  add_foreign_key "interesapais", "usuario", column: "usuario", primary_key: "name", name: "interesapais_usuario_fkey", on_delete: :cascade
  add_foreign_key "mensaje", "participa", column: ["usuario", "community"], primary_key: ["usuario", "community"], name: "mensaje_usuario_fkey", on_delete: :cascade
  add_foreign_key "participa", "community", column: "community", primary_key: "name", name: "participa_community_fkey", on_delete: :cascade
  add_foreign_key "participa", "usuario", column: "usuario", primary_key: "name", name: "participa_usuario_fkey", on_delete: :cascade
  add_foreign_key "usuario", "pais", column: "paisorigen", primary_key: "name", name: "usuario_paisorigen_fkey", on_delete: :cascade
  add_foreign_key "usuario", "pais", column: "paisresidencia", primary_key: "name", name: "usuario_paisresidencia_fkey", on_delete: :cascade
end
