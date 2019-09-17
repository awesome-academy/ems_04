class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :question_content
      t.integer :score, default: 0
      t.integer :question_type, default: 0
      t.integer :create_by
      t.references :subject, foreign_key: true

      t.timestamps
    end
  end
end
