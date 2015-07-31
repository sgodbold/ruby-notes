class AddPositionToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :position, :number
  end
end
