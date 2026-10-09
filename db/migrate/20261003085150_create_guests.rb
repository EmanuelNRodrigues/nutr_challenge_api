class CreateGuests < ActiveRecord::Migration[7.2]
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps

      t.index "LOWER(email)", unique: true, name: "index_guests_on_lower_email"
    end
  end
end
