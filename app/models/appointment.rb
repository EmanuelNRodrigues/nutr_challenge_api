# == Schema Information
#
# Table name: appointments
#
#  id                      :bigint           not null, primary key
#  start_date_time         :datetime         not null
#  end_date_time           :datetime         not null
#  status                  :integer          default("pending"), not null
#  guest_id                :bigint           not null
#  nutritionist_service_id :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Appointment < ApplicationRecord
  class InvalidTransitionError < StandardError; end

  belongs_to :guest
  belongs_to :nutritionist_service

  MIN_TIME_TO_SCHEDULE = 1.hour.from_now
  MAX_TIME_TO_SCHEDULE = 3.months.from_now

  # Todo: Review if makes sense status to be a nil - pending, true - approved, false - rejected
  enum :status, { pending: 0, approved: 1, rejected: 2, canceled: 3 }

  validate :scheduled_times_are_valid, on: :create

  scope :with_time_overlapping, ->(nutritionist_id, start_date, end_date) {
    joins(:nutritionist_service)
      .where(nutritionist_services: { nutritionist_id: nutritionist_id })
      .where(
        "appointments.start_date_time < ? AND appointments.end_date_time > ?",
        end_date,
        start_date
      )
  }

  scope :filled_slots_for_nutritionists, ->(nutritionist_ids) {
    joins(:nutritionist_service)
      .where(nutritionist_services: { nutritionist_id: nutritionist_ids })
      .where(status: :approved)
      .where(
        start_date_time: MIN_TIME_TO_SCHEDULE..MAX_TIME_TO_SCHEDULE
      )
      .order(:start_date_time)
  }

  private

  def scheduled_times_are_valid
    unless start_date_time.present?
      errors.add(:start_date_time, "can't be blank")
    end

    unless end_date_time.present?
      errors.add(:end_date_time, "can't be blank")
      return
    end

    if start_date_time < MIN_TIME_TO_SCHEDULE
      errors.add(:start_date_time, "must be at least 1 hour from now")
    end

    if end_date_time < MIN_TIME_TO_SCHEDULE + 15.minutes
      errors.add(:end_date_time, "must be at least 1 hour and 15 minutes from now")
    end

    if start_date_time >= end_date_time
      errors.add(:end_date_time, "must be after start date time")
    end

    if start_date_time >= MAX_TIME_TO_SCHEDULE
      errors.add(:start_date_time, "must be within 3 months from now")
    end
  end
end
