class AddStatusOptionToTasks < ActiveRecord::Migration[5.2]
  def change
    # [形式] change_column(テーブル名, カラム名, データタイプ, オプション)
    change_column :tasks, :priority, :integer, default: 1, null: false, limit: 1
    change_column :tasks, :status, :integer, default: 1, null: false, limit: 1
  end
end
