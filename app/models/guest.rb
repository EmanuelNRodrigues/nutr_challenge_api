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
class Guest < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :nutritionist_services, through: :appointments

  validates :name, presence: true
  validates :email, format: { with: EMAIL_REGEX, message: "Email invalid"  },
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 254 }
end
