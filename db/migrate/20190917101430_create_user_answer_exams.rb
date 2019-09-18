class CreateUserAnswerExams < ActiveRecord::Migration[5.1]
  def change
    create_table :user_answer_exams do |t|
      t.references :exam, foreign_key: true
      t.integer :status, default: 0
      t.integer :question_id
      t.text :answer_user
      t.boolean :is_correct, default: false

      t.timestamps
    end
  end
end
