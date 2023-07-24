class AddCreatedByToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :created_by
  end
end
