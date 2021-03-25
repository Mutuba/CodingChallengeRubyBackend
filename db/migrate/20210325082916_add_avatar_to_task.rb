# frozen_string_literal: true

class AddAvatarToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :avatar, :string
  end
end
