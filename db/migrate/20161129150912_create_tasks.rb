class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :description, null: false
      t.string :type, null: false
      t.integer :percent
      t.date :since
      t.date :until

      t.timestamps
    end
  end
end
