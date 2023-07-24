class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :task_type
      t.datetime :completion_date

      t.timestamps
    end
  end
end
