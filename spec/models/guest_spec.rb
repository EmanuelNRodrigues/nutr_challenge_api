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
  subject { build(:guest) }

  it 'must have a name' do
    subject.name = ''
    expect(subject).not_to be_valid
  end

  it 'must have a valid email' do
    subject.email = 'not_an_email'
    expect(subject).not_to be_valid
  end

  it 'must have a unique email (case insensitive)' do
    email = 'TESTEMAIL@test.pt'
    subject.email = email
    create(:guest, email: email.downcase)
    expect(subject).not_to be_valid
  end
end
