class ChangeStatusOptionToTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :priority, :integer, default: 1, null: true, limit: 1
    change_column :tasks, :status, :integer, default: 1, null: true, limit: 1
  end
end
