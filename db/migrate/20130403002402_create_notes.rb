class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :title
      t.string :body
      t.integer :x
      t.integer :y
      t.integer :width
      t.references :board

      t.timestamps
    end
    add_index :notes, :board_id
  end
end
