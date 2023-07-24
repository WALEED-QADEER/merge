class RemovecompletionFromprojects < ActiveRecord::Migration[7.0]
  def change
    remove_column :projects, :completion
  end
end
