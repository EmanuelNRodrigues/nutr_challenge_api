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
class NutritionistService < ApplicationRecord
  belongs_to :nutritionist
  belongs_to :service
  has_many :appointments, dependent: :destroy
end
