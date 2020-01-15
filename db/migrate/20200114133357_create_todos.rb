class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :status
      t.string :title

      t.timestamps
    end
  end
end
