# == Schema Information
#
# Table name: services
#
#  id                  :bigint           not null, primary key
#  name                :string           not null
#  price               :decimal(10, 2)   not null
#  duration_in_minutes :integer          not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
FactoryBot.define do
  factory :service do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 10.0..100.0) }
    duration_in_minutes { [30, 45, 60, 90].sample }
    location
  end
end
