class ChangeNotesPositionToInteger < ActiveRecord::Migration
  def change
    remove_column :notes, :position
    add_column :notes, :position, :integer
  end
end
