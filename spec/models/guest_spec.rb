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
require 'rails_helper'

RSpec.describe Guest, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
