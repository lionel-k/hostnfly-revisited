# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mission, type: :model do
  let(:listing) do
    Listing.create!(num_rooms: 2)
  end

  let(:valid_attributes) do
    { listing: listing,
      date: '2016-10-11',
      mission_type: :last_checkout,
      price: 5 }
  end

  it 'has a date' do
    mission = Mission.new(valid_attributes)

    expect(mission.date).to eq(Date.parse('2016-10-11'))
  end

  it 'has a mission_type' do
    mission = Mission.new(valid_attributes)

    expect(mission.mission_type).to eq('last_checkout')
  end

  it 'has a price' do
    mission = Mission.new(valid_attributes)

    expect(mission.price).to eq(5)
  end

  it 'date cannot be blank' do
    attributes = valid_attributes
    attributes.delete(:date)
    mission = Mission.new(attributes)

    expect(mission).not_to be_valid
  end

  it 'mission_type cannot be blank' do
    attributes = valid_attributes
    attributes.delete(:mission_type)
    mission = Mission.new(attributes)

    expect(mission).not_to be_valid
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
