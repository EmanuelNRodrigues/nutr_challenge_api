class AppointmentRejector
  class InvalidTransitionError < StandardError; end

  def initialize(appointment_id)
    @appointment_id = appointment_id
  end

  def call
    @appointment = Appointment.find(@appointment_id)
    nutritionist = @appointment.nutritionist_service.nutritionist

    nutritionist.with_lock do
      @appointment.lock!

      ensure_pending!

      @appointment.update!(status: :rejected)

      @appointment
    end
  end

  private

  def ensure_pending!
    return if @appointment.pending?

    raise InvalidTransitionError,
          "Appointment #{@appointment.id} cannot be rejected from #{@appointment.status} state"
  end
end
