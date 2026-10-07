class AppointmentCreator
  class ScheduleAlreadyFilled < StandardError; end
  def initialize(nutritionist_service, guest_name, guest_email, start_date_time)
    @nutritionist_service = nutritionist_service
    @nutritionist = nutritionist_service.nutritionist
    @service = nutritionist_service.service
    @guest_name = guest_name
    @guest_email = guest_email
    @start_date_time = Time.zone.parse(start_date_time)
    @end_date_time = @start_date_time + @service.duration_in_minutes.minutes
  end

  def call
    Nutritionist.transaction do
      @nutritionist.with_lock do
        raise ScheduleAlreadyFilled if is_schedule_already_filled?

        guest = Guest.find_or_initialize_by(email: @guest_email.strip.downcase)

        if guest.persisted?
          Appointment.where(guest:, status: :pending)
                     .update_all(status: :canceled, updated_at: Time.current)
        end

        if guest.name != @guest_name
          guest.name = @guest_name
          guest.save!
        end

        Appointment.create!(guest:,
                            nutritionist_service: @nutritionist_service,
                            start_date_time: @start_date_time,
                            end_date_time: @end_date_time,
                            status: :pending)
      end
    end
  end

  private

  def is_schedule_already_filled?
    Appointment.with_time_overlapping(@nutritionist.id, @start_date_time, @end_date_time)
               .where(status: :approved)
               .exists?
  end
end
