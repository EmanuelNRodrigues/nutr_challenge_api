# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :location do
    address { "MyString" }
    service { nil }
  end
end
