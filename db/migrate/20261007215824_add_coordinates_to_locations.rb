class AddCoordinatesToLocations < ActiveRecord::Migration[7.2]
  def change
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
    add_index :locations, [:latitude, :longitude]
  end
end
