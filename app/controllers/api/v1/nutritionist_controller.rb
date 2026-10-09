class Api::V1::NutritionistController < ApplicationController

  # POST /api/v1/nutritionist/:id/appointment/:appointment_id/accept
  def accept_appointment
    AppointmentApprover.new(params[:appointment_id]).call

    render json: { message: 'Appointment accepted.' }, status: :ok
  end

  # POST /api/v1/nutritionist/:id/appointment/:appointment_id/reject
  def reject_appointment
    AppointmentRejector.new(params[:appointment_id]).call

    render json: { message: 'Appointment rejected.' }, status: :ok
  end

  def fetch_appointment
    Appointment.joins(:nutritionist_service)
               .find_by!( id: params[:appointment_id],
                          nutritionist_services: { nutritionist_id: params[:id] } )
  end
  # GET /api/v1/nutritionist/:id/pending_appointments
  def pending_appointments
    appointments = Appointment.joins(nutritionist_service: :service)
                              .where(nutritionist_services: { nutritionist_id: params[:id] }, status: :pending)
                              .preload(:guest, nutritionist_service: :service)

    render json: serialize_appointments(appointments), status: :ok
  end

  private

  def serialize_appointments(appointments)
    appointments.map do |appointment|
      {
        id: appointment.id,
        start_date_time: appointment.start_date_time,
        end_date_time: appointment.end_date_time,
        guest_id: appointment.guest_id,
        nutritionist_service_id: appointment.nutritionist_service_id,
        guest_name: appointment.guest.name,
        guest_email: appointment.guest.email,
        service_name: appointment.nutritionist_service.service.name,
        service_price: appointment.nutritionist_service.service.price,
        service_duration: appointment.nutritionist_service.service.duration_in_minutes
      }
    end
  end
end
