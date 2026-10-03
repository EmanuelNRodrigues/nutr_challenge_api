# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  address    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Location < ApplicationRecord
  has_many :services, dependent: :destroy

  validates :address, presence: true
end
