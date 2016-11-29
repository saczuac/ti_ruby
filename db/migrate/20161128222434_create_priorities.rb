class CreatePriorities < ActiveRecord::Migration[5.0]
  def change
    create_table :priorities do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
