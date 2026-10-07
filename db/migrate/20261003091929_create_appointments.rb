class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.datetime :start_date_time, null: false
      t.datetime :end_date_time, null: false
      t.integer :status, null: false, default: 0
      t.references :guest, null: false, foreign_key: true
      t.references :nutritionist_service, null: false, foreign_key: true

      t.timestamps

      # Used when checking for existing appointments for a nutritionist
      t.index [:nutritionist_service_id, :status, :start_date_time, :end_date_time]
      # Used when cancelling a guest's pending appointments
      t.index [:guest_id, :status]
    end
  end
end
