class ChangeTasksDefaltValue < ActiveRecord::Migration[5.2]
    def up
      change_column_default :tasks, :status, 0
      change_column_default :tasks, :priority, 1
    end

    def down
      change_column_default :tasks, :status, nil
      change_column_default :tasks, :status, nil
    end
end
