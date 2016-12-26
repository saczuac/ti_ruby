class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :description, null: false
      t.string :type, null: false
      t.integer :percent, null: true
      t.date :since, null: true
      t.date :until, null:true
      t.belongs_to :state, index: true
      t.belongs_to :list, index: true
      t.belongs_to :priority, index: true
      t.timestamps
    end
  end
end
