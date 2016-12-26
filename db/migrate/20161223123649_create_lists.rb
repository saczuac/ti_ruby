class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :title
      t.string :slug

      t.timestamps
    end
  end
end
