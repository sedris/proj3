class AddListInfo < ActiveRecord::Migration
	# adding :height, :width, :x, :y, removing :title
  def up
    remove_column :lists, :title
    add_column :lists, :height, :integer
    add_column :lists, :width, :integer
    add_column :lists, :x, :integer
    add_column :lists, :y, :integer
  end

  def down
    remove_column :lists, :height
    remove_column :lists, :width
    remove_column :lists, :x
    remove_column :lists, :y
    add_column :lists, :title, :string
  end
end
