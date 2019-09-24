class AddDeletedTosubjects < ActiveRecord::Migration[5.1]
  def change
    add_column :subjects, :is_deleted, :integer, default: 0
    add_column :subjects, :deleted_at, :datetime
  end
end
