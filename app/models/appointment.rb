# == Schema Information
#
# Table name: appointments
#
#  id                      :bigint           not null, primary key
#  scheduled_date_time     :datetime         not null
#  status                  :integer          default("pending"), not null
#  guest_id                :bigint           not null
#  nutritionist_service_id :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Appointment < ApplicationRecord
  belongs_to :guest
  belongs_to :nutritionist_service

  enum status: { pending: 0, approved: 1, rejected: 2, canceled: 3 }

  validate :scheduled_date_time_must_be_in_the_future, on: :create


  private

  def scheduled_date_time_must_be_in_the_future
    unless scheduled_date_time.present?
      errors.add(:scheduled_date_time, "can't be blank")
      return
    end

    if scheduled_date_time_changed? && scheduled_date_time < Time.current
      errors.add(:scheduled_date_time, "can't be in the past") if scheduled_date_time < Time.current
    end
  end
end
