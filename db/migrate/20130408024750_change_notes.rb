class ChangeNotes < ActiveRecord::Migration
  # add height, remove title and board_id to notes
  def up
  	remove_index :notes, :board_id
  	remove_column :notes, :board_id
  	add_column :notes, :height, :integer
  	remove_column :notes, :title
  end

  def down
  	add_column :notes, :title, :string
  	remove_column :notes, :height
  	add_column :notes, :board_id, :integer
  	add_index :notes, :board_id
  end
end
