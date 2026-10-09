class Api::V1::Public::GuestController < ApplicationController
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
    results = NutritionistServiceListing.new(
      query: params[:query],
      location_address: params[:location_address]
    ).call

    serialized_results = results.map do |result|
      serialize_nutritionists_information(
        result[:nutritionist],
        result[:nutritionist_services],
        result[:filled_slots]
      )
    end

    render json: serialized_results, status: :ok
  end

  private

  def serialize_nutritionists_information(nutritionist, nutritionist_services, filled_slots)
    {
      id: nutritionist.id,
      name: nutritionist.name,
      email: nutritionist.email,
      services: nutritionist_services.map do |nutritionist_service|
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
    filled_slots: filled_slots
    }
  end
end
