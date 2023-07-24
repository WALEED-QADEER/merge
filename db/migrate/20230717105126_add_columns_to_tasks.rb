class AddColumnsToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :description, :text
    add_reference :tasks, :user,  foreign_key: true
    add_reference :tasks, :project,  foreign_key: true
  end
end
