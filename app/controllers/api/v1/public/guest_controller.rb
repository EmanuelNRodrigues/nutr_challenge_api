class Api::V1::Public::GuestController < ApplicationController
  class ScheduleAlreadyFilled < StandardError; end


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

  # listagem de nutricionistas, servicos associados e horarios disponiveis.
  # filtrar opcionalmente por nome do nutricionista, nome do servico, localizacao do servico
  # GET /api/v1/guest/nutritionist_service
  def list_nutritionists_and_services
    nutritionists = Nutritionist
                      .includes(nutritionist_services: { service: :location })
                      .order(:name)
                      .limit(50)

    if params[:query].present?
      nutritionists = nutritionists.where(id: filtered_nutritionist_ids)
    end
    filled_slots_by_nutritionist = FilledSlotsFinder.new(nutritionists.pluck(:id)).call

    render json: nutritionists.map { |nutritionist| serialize_nutritionist(nutritionist, filled_slots_by_nutritionist) },
           status: :ok
  end



  private

  def filtered_nutritionist_ids
    return nil unless params[:query].present?

    query = "%#{ActiveRecord::Base.sanitize_sql_like(params[:query])}%"

    Nutritionist
      .joins(nutritionist_services: :service)
      .includes(nutritionist_services: { service: :location })
      .where(
        "nutritionists.name ILIKE :query OR services.name ILIKE :query",
        query:
      )
      .distinct
      .select(:id)
  end

  def serialize_nutritionist(nutritionist, filled_slots)
    {
      id: nutritionist.id,
      name: nutritionist.name,
      email: nutritionist.email,
      services: nutritionist.nutritionist_services.map do |nutritionist_service|
        service = nutritionist_service.service
        location = service.location

        {
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
