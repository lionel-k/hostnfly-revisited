# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Listing, type: :model do
  let(:valid_attributes) do
    {
      num_rooms: 2
    }
  end

  it 'has a num_rooms' do
    listing = Listing.new(num_rooms: 4)
    expect(listing.num_rooms).to eq(4)
  end

  it 'num_rooms cannot be blank' do
    attributes = valid_attributes
    attributes.delete(:num_rooms)
    listing = Listing.new(attributes)
    expect(listing).not_to be_valid
  end

  it 'should destroy child bookings when destroying self' do
    listing = Listing.create!(valid_attributes)
    listing.bookings.create!(start_date: '2016-10-10', end_date: '2016-10-15')

    expect { listing.destroy }.to change { Booking.count }.from(1).to(0)
  end

  it 'has many bookings' do
    listing = Listing.create!(valid_attributes)
    expect(listing).to respond_to(:bookings)
    expect(listing.bookings.count).to eq(0)

    listing.bookings.create!(start_date: '2016-10-10', end_date: '2016-10-15')
    expect(listing.bookings.count).to eq(1)
  end

  it 'has many reservations' do
    listing = Listing.create!(valid_attributes)
    expect(listing).to respond_to(:reservations)
    expect(listing.reservations.count).to eq(0)

    listing.reservations.create!(start_date: '2016-10-10', end_date: '2016-10-15')
    expect(listing.reservations.count).to eq(1)
  end

  it 'has many missions' do
    listing = Listing.create!(valid_attributes)
    expect(listing).to respond_to(:missions)
    expect(listing.reservations.count).to eq(0)

    listing.bookings.create!(start_date: '2016-10-10', end_date: '2016-10-15')
    listing.bookings.create!(start_date: '2016-10-16', end_date: '2016-10-20')
    listing.reservations.create!(start_date: '2016-10-11', end_date: '2016-10-13')
    listing.reservations.create!(start_date: '2016-10-13', end_date: '2016-10-15')
    listing.reservations.create!(start_date: '2016-10-16', end_date: '2016-10-20')

    expect(listing.missions.count).to eq(5)
  end
end
