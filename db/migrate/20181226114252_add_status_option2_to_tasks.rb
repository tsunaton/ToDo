class AddStatusOption2ToTasks < ActiveRecord::Migration[5.2]
  def change
    # [形式] change_column(テーブル名, カラム名, データタイプ, オプション)
    change_column :tasks, :status, :integer, default: 0
  end
end
