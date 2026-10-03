# == Schema Information
#
# Table name: nutritionist_services
#
#  id              :bigint           not null, primary key
#  nutritionist_id :bigint           not null
#  service_id      :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :nutritionist_service do
    nutritionist { nil }
    service { nil }
  end
end
