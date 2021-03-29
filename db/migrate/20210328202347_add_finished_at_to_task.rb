# frozen_string_literal: true

class AddFinishedAtToTask < ActiveRecord::Migration[6.1]
  def up
    add_column :tasks, :finished_at, :datetime
  end

  def down
    remove_column :tasks, :finished_at, :datetime
  end
end
