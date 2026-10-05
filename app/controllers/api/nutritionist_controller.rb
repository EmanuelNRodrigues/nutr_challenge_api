class Api::V1::NutritionistController < ApplicationController

  # Mudar o status do appointment para accepted.
  # Job? Verificar outros appointments do mesmo nutricionista para o mesmo periodo overlap, e passar estes a rejected.
  # Job para enviar email para o guest do appointment aceito, e para os guests dos appointments rejeitados, informando que o appointment foi rejeitado.
  # Job para enviar email para o guest do appointment aceito, e para os guests do appointment aprovado, informando que o appointment foi aceito.
  # POST /api/v1/nutritionist/:id/appointment/:appointment_id/accept
  def accept_appointment
    appointment = Appointment.joins(:nutritionist_service)
                             .where(id: params[:appointment_id],
                                    nutritionist_services: { nutritionist_id: params[:id] })
                             .first

    appointment.approve!(reject_same_time: true) if appointment.present?

    render json: { message: 'Appointment accepted and overlapping appointments rejected.' }, status: :ok
  end

  # Mudar o status do appointment para rejected.
  # Job para enviar email para o guest do appointment rejeitado, informando que o appointment foi rejeitado.
  # POST /api/v1/nutritionist/:id/appointment/:appointment_id/reject
  def reject_appointment
    appointment = Appointment.joins(:nutritionist_service).where(id: params[:appointment_id],
                                                                 nutritionist_services: { nutritionist_id: params[:id] }).first

    appointment.reject! if appointment.present?

    render json: { message: 'Appointment rejected.' }, status: :ok
  end

  # Devolver a lista de appointments do nutricionista, com status pending
  # Adicionar info do guest e do servico
  # GET /api/v1/nutritionist/:id/pending_appointments
  def pending_appointments
    appointments = Appointment.joins(nutritionist_service: :service)
                              .where(nutritionist_services: { nutritionist_id: params[:id] }, status: :pending)
                              .includes(:guest, nutritionist_service: :service)
                              .select(<<~SQL)
      appointments.*, guests.name AS guest_name, guests.email AS guest_email,
      services.name AS service_name, services.price AS service_price,
      services.duration_in_minutes AS service_duration
    SQL

    render json: appointments.as_json, status: :ok
  end

end
