# == Schema Information
#
# Table name: nutritionists
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Nutritionist < ApplicationRecord
  has_many :nutritionist_services, dependent: :destroy
  has_many :services, through: :nutritionist_services

  validates :name, presence: true
  validates :email, format: { with: EMAIL_REGEX, message: "Email invalid"  },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }
end
