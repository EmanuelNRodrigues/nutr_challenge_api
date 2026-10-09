# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  latitude   :float
#  longitude  :float
#
FactoryBot.define do
  factory :location do
    address { 'Braga' }
    latitude { 41.5510583 }
    longitude { -8.4280045 }
  end
end
