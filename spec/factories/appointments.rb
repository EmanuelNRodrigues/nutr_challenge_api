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
FactoryBot.define do
  factory :appointment do
    scheduled_date_time { "2026-10-03 09:19:29" }
    status { "MyString" }
    guest_id { nil }
    nutritionist_service { nil }
  end
end
