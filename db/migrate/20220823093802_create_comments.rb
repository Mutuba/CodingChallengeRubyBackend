class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :commented_on_id
      t.string :commented_on_type

      t.timestamps
    end
  end
end
