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

ActiveRecord::Schema[7.1].define(version: 2025_06_06_210748) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "blogs", force: :cascade do |t|
    t.string "titulo"
    t.text "descripcion"
    t.string "tipo_publicacion"
    t.string "estado"
    t.integer "id_moderador"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "etiquetas"
    t.integer "id_autor"
    t.text "mensaje_moderacion"
    t.string "attachment"
    t.string "game_name"
    t.index ["id_autor"], name: "index_blogs_on_id_autor"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.bigint "blog_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_chat_rooms_on_blog_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "chat_room_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_room_id"], name: "index_messages_on_chat_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", primary_key: "id_reseña", force: :cascade do |t|
    t.integer "id_blog", null: false
    t.float "calificacion", null: false
    t.text "descripcion", null: false
    t.integer "id_usuario", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id_blog"], name: "index_reviews_on_id_blog"
    t.index ["id_usuario"], name: "index_reviews_on_id_usuario"
  end

  create_table "solicitudes_edicion", force: :cascade do |t|
    t.bigint "blog_id", null: false
    t.bigint "usuario_id", null: false
    t.string "estado", default: "pendiente"
    t.string "titulo"
    t.text "descripcion"
    t.string "tipo_publicacion"
    t.string "etiquetas"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_solicitudes_edicion_on_blog_id"
    t.index ["usuario_id"], name: "index_solicitudes_edicion_on_usuario_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre"
    t.text "descripcion"
    t.string "telefono"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blogs", "users", column: "id_autor"
  add_foreign_key "chat_rooms", "blogs"
  add_foreign_key "messages", "chat_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "reviews", "blogs", column: "id_blog"
  add_foreign_key "reviews", "users", column: "id_usuario"
  add_foreign_key "solicitudes_edicion", "blogs"
  add_foreign_key "solicitudes_edicion", "users", column: "usuario_id"
end
