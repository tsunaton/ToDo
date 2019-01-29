class RenameDescriptionColumnToTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :descripition, :description
  end
end
