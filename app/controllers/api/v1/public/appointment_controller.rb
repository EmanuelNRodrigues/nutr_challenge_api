class Api::V1::Public::AppointmentController < ApplicationController
  class ScheduleAlreadyFilled < StandardError; end

  before_action :validate_params

  # POST /api/v1/appointment
  def create
    # TODO: Verify return the information to the user that he has already a scheduled nutritionist if he want's to remove the old appointment to schedule the new one.
    nutritionist_service = NutritionistService.joins(:nutritionist, :service)
                                              .find_by!(nutritionist: {email: params[:nutritionist_email]},
                                                       service: { name: params[:service_name] } )

    Nutritionist.transaction do
      nutritionist_service.nutritionist.with_lock do
        start_date_time = Time.zone.parse(params[:start_appointment_date_time])
        end_date_time = start_date_time + nutritionist_service.service.duration_in_minutes.minutes

        raise ScheduleAlreadyFilled if is_schedule_already_filled?(nutritionist_service, start_date_time, end_date_time)

        guest = Guest.find_or_initialize_by(email: params[:guest_email])
        Appointment.where(guest:, status: :pending).update_all(status: :canceled) if guest.persisted?

        guest.update!(name: params[:guest_name]) if guest.name != params[:guest_name]
        Appointment.create!(guest:, nutritionist_service:,
                            start_date_time: ,
                            end_date_time: ,
                            status: :pending)
      end
    end

    render json: { message: 'Appointment scheduled successfully'}, status: :ok

    rescue ScheduleAlreadyFilled
      render json: { message: 'Scheduled time was already filled' }, status: :bad_request
  end


  private

  def validate_params
    params.require([:guest_email, :guest_name, :start_appointment_date_time, :nutritionist_email, :service_name])
  end

  def is_schedule_already_filled?(nutritionist_service, start_date, end_date)
    # TODO: Index to increase performance? WE could add nutritionist to create a index nutrititionist start_date_time conditional by status approved and the index nutritionist end_date_time. Could it be nutritionist start_date_time end_date_time?
    Appointment.joins(:nutritionist_service).where(nutritionist_services: { nutritionist_id: nutritionist_service.nutritionist_id })
               .where(status: :approved)
               .where("start_date_time < ? AND end_date_time > ?", end_date, start_date)
               .exists?
  end
end
