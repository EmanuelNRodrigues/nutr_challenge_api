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
FactoryBot.define do
  factory :appointment do
    start_date_time { Time.now + 1.day }
    end_date_time { Time.now + 1.day + 30.minutes}
    status { 'pending' }
    guest
    nutritionist_service
  end
end
