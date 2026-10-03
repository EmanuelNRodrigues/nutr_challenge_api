class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.datetime :start_date_time, null: false
      t.datetime :end_date_time, null: false
      t.integer :status, null: false, default: 0
      t.references :guest, null: false, foreign_key: true
      t.references :nutritionist_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
