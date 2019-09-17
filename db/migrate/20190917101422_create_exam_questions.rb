class CreateExamQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :exam_questions do |t|
      t.integer :exam_id
      t.integer :question_id

      t.timestamps
    end
    add_index :exam_questions, [:exam_id, :question_id]
  end
end
