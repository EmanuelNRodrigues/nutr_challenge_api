class AppointmentApprover
  class InvalidTransitionError < StandardError; end
  class ScheduleAlreadyFilled < StandardError; end

  def initialize(appointment_id)
    @appointment_id = appointment_id
  end

  def call
    @appointment = Appointment.includes(nutritionist_service: :nutritionist)
                              .find(@appointment_id)

    nutritionist = @appointment.nutritionist_service.nutritionist

    nutritionist.with_lock do
      @appointment.lock!

      ensure_pending!
      ensure_schedule_available!
      reject_conflicting_pending_appointments

      @appointment.update!(status: :approved)

      @appointment
    end
  end

  private

  def ensure_pending!
    return if @appointment.pending?

    raise InvalidTransitionError,
          "Appointment #{@appointment.id} cannot be approved from #{@appointment.status} state"
  end

  def ensure_schedule_available!
    conflict_exists =
      Appointment
        .with_time_overlapping(
          @appointment.nutritionist_service.nutritionist_id,
          @appointment.start_date_time,
          @appointment.end_date_time
        )
        .approved
        .where.not(id: @appointment.id)
        .exists?

    raise ScheduleAlreadyFilled if conflict_exists
  end
  def reject_conflicting_pending_appointments
    Appointment
      .with_time_overlapping(
        @appointment.nutritionist_service.nutritionist_id,
        @appointment.start_date_time,
        @appointment.end_date_time
      )
      .pending
      .where.not(id: @appointment.id)
      .update_all(
        status: Appointment.statuses[:rejected],
        updated_at: Time.current
      )
  end
end