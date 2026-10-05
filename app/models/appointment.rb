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
  belongs_to :guest
  belongs_to :nutritionist_service

  # Todo: Review if makes sense status to be a nil - pending, true - approved, false - rejected
  enum :status, { pending: 0, approved: 1, rejected: 2, canceled: 3 }

  validate :date_times_are_correct, on: :create

  scope :with_time_overlapping, ->(nutritionist_id, start_time, end_time) {
    where("start_date_time < ? AND end_date_time > ?", end_time, start_time)
      .where(nutritionist_id: nutritionist_id)
  }

  private

  def date_times_are_correct
    unless start_date_time.present?
      errors.add(:start_date_time, "can't be blank")
    end

    unless end_date_time.present?
      errors.add(:end_date_time, "can't be blank")
      return
    end

    if start_date_time < Time.current
      errors.add(:start_date_time, "can't be in the past")
    end

    if end_date_time < Time.current
      errors.add(:end_date_time, "can't be in the past")
    end

    if start_date_time >= end_date_time
      errors.add(:end_date_time, "must be after start date time")
    end
  end

  def approve!(reject_same_time: false)
    self.status = :approved
    save!
    Email::ApprovedAppointmentNotifierJob.perform_later(self.id)

    if reject_same_time
      # Reject other appointments within the same time range for the same nutritionist service
      Appointment.with_time_overlapping(self.nutritionist_service.nutritionist.id, self.start_date_time, self.end_date_time)
                 .each do |appointment|
        appointment.reject!
      end
    end
  end

  def reject!
    self.status = :rejected
    save!
    Email::RejectedAppointmentNotifierJob.perform_later(self.id)
  end
end
