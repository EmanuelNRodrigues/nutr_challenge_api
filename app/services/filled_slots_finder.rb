class FilledSlotsFinder
  def initialize(nutritionist_ids)
    @nutritionist_ids = nutritionist_ids
  end

  def call
    return {} if @nutritionist_ids.empty?

    Appointment.filled_slots_for_nutritionists(@nutritionist_ids)
      .pluck(
        "nutritionist_services.nutritionist_id",
        "appointments.start_date_time",
        "appointments.end_date_time"
      )
      .group_by(&:first)
      .transform_values do |slots|
      slots.map do |_, start_date_time, end_date_time|
        {
          start_date_time: start_date_time,
          end_date_time: end_date_time
        }
      end
    end
  end
end