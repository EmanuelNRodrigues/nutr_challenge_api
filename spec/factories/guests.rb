# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :guest do
    name { Faker::Name.name }
    email { Faker::Internet.email }
  end
end
