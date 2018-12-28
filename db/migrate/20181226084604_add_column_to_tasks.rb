class AddColumnToTasks < ActiveRecord::Migration[5.2]
  def up
    add_column :tasks, :user_id, :integer
  end
end
