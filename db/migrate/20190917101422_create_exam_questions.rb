class CreateExamQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :exams_questions do |t|
      t.integer :exam_id
      t.integer :question_id

      t.timestamps
    end
    add_index :exams_questions, [:exam_id, :question_id]
  end
end
