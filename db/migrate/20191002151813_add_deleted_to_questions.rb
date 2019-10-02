class AddDeletedToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :is_deleted, :integer, default: 0
    add_column :questions, :deleted_at, :datetime
  end
end
