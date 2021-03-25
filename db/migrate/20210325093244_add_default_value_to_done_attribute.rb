class AddDefaultValueToDoneAttribute < ActiveRecord::Migration[6.1]
  def up
    change_column :tasks, :finished, :boolean, default: false
  end

  def down
    change_column :tasks, :finished, :boolean, default: nil
  end
end
