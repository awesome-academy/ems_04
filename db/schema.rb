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

ActiveRecord::Schema.define(version: 20191002151813) do
  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "answer_content"
    t.bigint "question_id"
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "start_time"
    t.datetime "finish_time"
    t.bigint "subject_id"
    t.bigint "user_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exam_score", default: 0
    t.boolean "is_passed", default: false
    t.index ["subject_id"], name: "index_exams_on_subject_id"
    t.index ["user_id"], name: "index_exams_on_user_id"
  end

  create_table "exams_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "exam_id"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id", "question_id"], name: "index_exams_questions_on_exam_id_and_question_id"
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "question_content"
    t.integer "score", default: 0
    t.integer "question_type", default: 0
    t.integer "create_by"
    t.bigint "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "is_deleted", default: 0
    t.datetime "deleted_at"
    t.index ["subject_id"], name: "index_questions_on_subject_id"
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "subject_name"
    t.integer "duaration", default: 20
    t.integer "total_score", default: 100
    t.integer "limit_questions", default: 30
    t.integer "create_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "is_deleted", default: 0
    t.datetime "deleted_at"
  end

  create_table "user_answer_exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "exam_id"
    t.integer "question_id"
    t.text "answer_user"
    t.boolean "is_correct", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_user_answer_exams_on_exam_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "last_name"
    t.string "first_name"
    t.string "email"
    t.string "bio"
    t.string "photo"
    t.integer "role", default: 0
    t.string "remember_digest"
    t.string "password_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "exams", "subjects"
  add_foreign_key "exams", "users"
  add_foreign_key "questions", "subjects"
  add_foreign_key "user_answer_exams", "exams"
end
