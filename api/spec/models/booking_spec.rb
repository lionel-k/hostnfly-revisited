# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Booking, type: :model do
  let(:listing) do
    Listing.create!(num_rooms: 2)
  end

  let(:valid_attributes) do
    { listing: listing,
      start_date: '2016-10-10',
      end_date: '2016-10-15' }
  end

  let(:invalid_attributes) do
    { listing: listing,
      start_date: '2016-10-15',
      end_date: '2016-10-10' }
  end

  it 'start_date/end_date cannot be blank' do
    attributes1 = valid_attributes
    attributes2 = valid_attributes
    attributes1.delete(:start_date)
    attributes2.delete(:end_date)
    booking1 = Booking.new(attributes1)
    booking2 = Booking.new(attributes2)

    expect(booking1).not_to be_valid
    expect(booking2).not_to be_valid
  end

  it 'has a start_date/end_date' do
    booking = Booking.new(valid_attributes)

    expect(booking.start_date).to eq(Date.parse('2016-10-10'))
    expect(booking.end_date).to eq(Date.parse('2016-10-15'))
  end

  it 'has a start_date <= end_date' do
    booking = Booking.new(invalid_attributes)

    expect(booking).not_to be_valid
  end

  it 'belongs to a listing' do
    booking = Booking.new(listing: listing)
    expect(booking.listing).to eq(listing)
  end

  it 'listing cannot be blank' do
    attributes = valid_attributes
    attributes.delete(:listing)
    booking = Booking.new(attributes)
    expect(booking).not_to be_valid
  end

  it 'has missions' do
    booking = Booking.create!(valid_attributes)
    expect(booking).to respond_to(:missions)
    expect(booking.missions.count).to eq(2)
  end

  it 'should destroy child missions and self when cancelling self' do
    booking = Booking.create!(valid_attributes)

    expect { booking.cancel }.to change { Mission.count }.from(2).to(0)
    expect(Booking.count).to eq(0)
  end
end
