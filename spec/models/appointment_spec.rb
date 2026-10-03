# == Schema Information
#
# Table name: appointments
#
#  id                      :bigint           not null, primary key
#  scheduled_date_time     :datetime         not null
#  status                  :integer          default("pending"), not null
#  guest_id                :bigint           not null
#  nutritionist_service_id :bigint           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
