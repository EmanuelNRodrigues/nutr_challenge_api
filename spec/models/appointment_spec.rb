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
  subject { build(:appointment) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a scheduled_date_time' do
    subject.scheduled_date_time = ''
    expect(subject).not_to be_valid
  end

  it 'is not valid with a scheduled_date_time in the past' do
    subject.scheduled_date_time = Time.now - 1.second
    expect(subject).not_to be_valid
  end

  it 'raises an error when assigned an invalid status' do
    expect { subject.status = 'invalid_status' }.to raise_error(ArgumentError, "'invalid_status' is not a valid status")
  end

  it 'is valid with the status set to pending, approved, rejected, or canceled' do
    %w[pending approved rejected canceled].each do |status|
      subject.status = status
      expect(subject).to be_valid
    end
  end

  it 'must be associated with a guest' do
    subject.guest = nil
    expect(subject).not_to be_valid
  end

  it 'must be associated with a nutritionist_service' do
    subject.nutritionist_service = nil
    expect(subject).not_to be_valid
  end
end
