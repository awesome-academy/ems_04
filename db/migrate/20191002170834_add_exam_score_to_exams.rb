class AddExamScoreToExams < ActiveRecord::Migration[5.1]
  def change
    add_column :exams, :exam_score, :integer, default: 0
    add_column :exams, :is_passed, :boolean, default: false
  end
end
