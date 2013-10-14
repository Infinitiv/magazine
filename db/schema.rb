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

ActiveRecord::Schema.define(version: 20131011055934) do

  create_table "article_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: true do |t|
    t.text     "title_ru"
    t.text     "title_en"
    t.text     "content_ru"
    t.text     "content_en"
    t.integer  "article_type_id"
    t.date     "expire"
    t.boolean  "published"
    t.text     "cut_content_ru"
    t.text     "cut_content_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["article_type_id"], name: "index_articles_on_article_type_id", using: :btree

  create_table "articles_attachments", id: false, force: true do |t|
    t.integer "article_id",    null: false
    t.integer "attachment_id", null: false
  end

  create_table "attachments", force: true do |t|
    t.string   "title"
    t.binary   "data",       limit: 16777215
    t.string   "mime_type"
    t.binary   "thumbnail"
    t.text     "content",    limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments_issues", id: false, force: true do |t|
    t.integer "attachment_id", null: false
    t.integer "issue_id",      null: false
  end

  create_table "attachments_publications", id: false, force: true do |t|
    t.integer "publication_id", null: false
    t.integer "attachment_id",  null: false
  end

  create_table "feedbacks", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "name"
    t.boolean  "administrator", default: false
    t.boolean  "editor",        default: false
    t.boolean  "viewer",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", force: true do |t|
    t.integer  "year"
    t.integer  "volume"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menus", force: true do |t|
    t.string   "title"
    t.string   "path"
    t.integer  "weigth"
    t.boolean  "private",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", force: true do |t|
    t.text     "title_ru"
    t.text     "title_en"
    t.text     "authors_ru"
    t.text     "authors_en"
    t.text     "keywords_ru"
    t.text     "keywords_en"
    t.text     "abstract_ru"
    t.text     "abstract_en"
    t.integer  "issue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publications", ["issue_id"], name: "index_publications_on_issue_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "password_digest"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["group_id"], name: "index_users_on_group_id", using: :btree

end
