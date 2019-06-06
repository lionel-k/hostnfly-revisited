# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mission, type: :model do
  let(:listing) do
    Listing.create!(num_rooms: 2)
  end

  let(:booking) do
    Booking.create!(listing: listing,
                    start_date: '2016-10-10', end_date: '2016-10-15')
  end

  let(:valid_attributes) do
    { listing: listing,
      date: '2016-10-11',
      mission_type: :last_checkout,
      price: 5 }
  end

  it 'has a date/mission_type/price' do
    mission = Mission.new(valid_attributes)

    expect(mission.date).to eq(Date.parse('2016-10-11'))
    expect(mission.price).to eq(5)
    expect(mission.mission_type).to eq('last_checkout')
  end

  it 'date/mission_type/price cannot be blank' do
    attributes1 = valid_attributes
    attributes2 = valid_attributes
    attributes3 = valid_attributes
    attributes1.delete(:date)
    attributes2.delete(:mission_type)
    attributes3.delete(:price)
    mission1 = Mission.new(attributes1)
    mission2 = Mission.new(attributes2)
    mission3 = Mission.new(attributes3)

    expect(mission1).not_to be_valid
    expect(mission2).not_to be_valid
    expect(mission3).not_to be_valid
  end

  it 'has a valid type' do
    attributes = valid_attributes
    attributes[:mission_type] = :wrong_mission
    mission = Mission.new(attributes)
    expect(mission).not_to be_valid
  end

  it 'return the right price' do
    expect(Mission.price_of(:first_checkin)).to eq(10)
    expect(Mission.price_of(:checkout_checkin)).to eq(10)
    expect(Mission.price_of(:last_checkout)).to eq(5)
  end
end
