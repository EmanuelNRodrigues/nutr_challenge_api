class Api::V1::Public::GuestController < ApplicationController
  class ScheduleAlreadyFilled < StandardError; end

  BRAGA_COORDINATES = [41.5510583, -8.4280045].freeze

  # POST /api/v1/guest/appointment
  def create_appointment
    params.require([:guest_email, :guest_name, :start_appointment_date_time, :nutritionist_email, :service_name])
    # TODO: Verify return the information to the user that he has already a scheduled nutritionist if he want's to remove the old appointment to schedule the new one.

    nutritionist_service = NutritionistService.joins(:nutritionist, :service)
                                              .find_by!(nutritionist: {email: params[:nutritionist_email]},
                                                       service: { name: params[:service_name] } )

    AppointmentCreator.new(nutritionist_service,
                           params[:guest_name],
                           params[:guest_email],
                           params[:start_appointment_date_time]).call

    render json: { message: "Appointment scheduled successfully" }, status: :created

    rescue AppointmentCreator::ScheduleAlreadyFilled
      render json: { message: 'Scheduled time was already filled' }, status: :conflict
  end

  # GET /api/v1/guest/nutritionist_service
  def list_nutritionists_informations
    coordinates = Geocoder.coordinates(params[:location_address]) || BRAGA_COORDINATES

    nutritionists = Nutritionist
                      .joins(nutritionist_services: [:service, :location])
                      .includes(nutritionist_services: [:service, :location])
                      .distinct

    nutritionists = nutritionists.where(id: filtered_nutritionist_ids) if params[:query].present?

    nutritionists = NutritionistDistanceSorter
                      .new(nutritionists, coordinates)
                      .call(limit: 50)

    filled_slots_by_nutritionist =
      FilledSlotsFinder.new(nutritionists.map(&:id)).call

    render json: nutritionists.map { |nutritionist|
      serialize_nutritionist(nutritionist, filled_slots_by_nutritionist)
    }, status: :ok
  end

  private


  def serialize_nutritionist(nutritionist, filled_slots)
    {
      id: nutritionist.id,
      name: nutritionist.name,
      email: nutritionist.email,
      services: nutritionist.nutritionist_services.map do |nutritionist_service|
        service = nutritionist_service.service
        location = nutritionist_service.location

        {
          id: service.id,
          name: service.name,
          price: service.price,
          duration_in_minutes: service.duration_in_minutes,
          location: {
            address: location.address
          }
        }
      end,
    filled_slots: filled_slots.fetch(nutritionist.id, [])
    }
  end
end
