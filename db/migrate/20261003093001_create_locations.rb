class CreateLocations < ActiveRecord::Migration[7.2]
  def change
    create_table :locations do |t|
      t.string :address, null: false

      t.timestamps
    end

    add_reference :services, :location, foreign_key: true
  end
end
