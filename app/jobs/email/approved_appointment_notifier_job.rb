class Email::ApprovedAppointmentNotifierJob < ApplicationJob
  queue_as :default

  def perform(appointment_id)
    # Logic to build and send email
  end
end
