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
require 'rails_helper'

RSpec.describe NutritionistService, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
