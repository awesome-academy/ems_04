class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :subject_name
      t.integer :duaration, default: 20
      t.integer :total_score, default: 100
      t.integer :limit_questions, default: 30
      t.integer :create_by

      t.timestamps
    end
  end
end
