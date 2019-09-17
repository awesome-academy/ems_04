class CreateExams < ActiveRecord::Migration[5.1]
  def change
    create_table :exams do |t|
      t.datetime :start_time
      t.references :subject, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :status, default: false

      t.timestamps
    end
  end
end
