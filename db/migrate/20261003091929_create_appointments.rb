class CreateAppointments < ActiveRecord::Migration[7.2]
  def change
    create_table :appointments do |t|
      t.datetime :start_date_time, null: false
      t.datetime :end_date_time, null: false
      t.integer :status, null: false, default: 0
      t.references :guest, null: false, foreign_key: true
      t.references :nutritionist_service, null: false, foreign_key: true

      t.timestamps

      # A guest can have many appointments, but only one pending appointment.
      t.index :guest_id, unique: true, where: "status = 0", name: "index_appointments_one_pending_per_guest"

      # Used to find approved appointments for a nutritionist/service by start time.
      t.index [:nutritionist_service_id, :start_date_time], where: "status = 1", name: "index_appointments_on_service_start_approved"
    end
  end
end
