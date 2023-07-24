class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :completion
      t.datetime :date

      t.timestamps
    end
  end
end
