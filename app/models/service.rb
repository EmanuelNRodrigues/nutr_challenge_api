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
#  location_id         :bigint
#
class Service < ApplicationRecord
  has_many :nutritionist_services, dependent: :destroy
  has_many :nutritionists, through: :nutritionist_services
  has_many :appointments, through: :nutritionist_services
  belongs_to :location

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :duration_in_minutes, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 180 }
end
