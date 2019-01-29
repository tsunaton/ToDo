class ChangeStatusAndPriorityOptionToTasks2 < ActiveRecord::Migration[5.2]
  def up
    change_column_default :tasks, :priority, nil
    change_column_default :tasks, :status, nil
  end

  def down
    change_column_default :tasks, :priority, 1
    change_column_default :tasks, :status, 1
  end
end
