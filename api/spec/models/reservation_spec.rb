# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:listing) do
    Listing.create!(num_rooms: 2)
  end

  let(:valid_attributes) do
    { listing: listing,
      start_date: '2016-10-11',
      end_date: '2016-10-13' }
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
    reservation1 = Reservation.new(attributes1)
    reservation2 = Reservation.new(attributes2)

    expect(reservation1).not_to be_valid
    expect(reservation2).not_to be_valid
  end

  it 'has a start_date/end_date' do
    reservation = Reservation.new(valid_attributes)

    expect(reservation.start_date).to eq(Date.parse('2016-10-11'))
    expect(reservation.end_date).to eq(Date.parse('2016-10-13'))
  end

  it 'has a start_date <= end_date' do
    reservation = Reservation.new(invalid_attributes)

    expect(reservation).not_to be_valid
  end

  it 'belongs to a listing' do
    reservation = Reservation.new(listing: listing)
    expect(reservation.listing).to eq(listing)
  end

  it 'listing cannot be blank' do
    attributes = valid_attributes
    attributes.delete(:listing)
    reservation = Reservation.new(attributes)
    expect(reservation).not_to be_valid
  end

  it 'has missions' do
    reservation = Reservation.create!(valid_attributes)
    expect(reservation).to respond_to(:missions)
    expect(reservation.missions.count).to eq(1)
  end

  it 'does not create a mission if last_checkout exists' do
    listing.bookings.create!(start_date: '2016-10-10', end_date: '2016-10-13')
    listing.reservations.create!(start_date: '2016-10-12', end_date: '2016-10-13')

    expect(Reservation.last.missions.count).to eq(0)
  end

  it 'should destroy child missions and self when cancelling self' do
    reservation = Reservation.create!(valid_attributes)

    expect { reservation.cancel }.to change { Mission.count }.from(1).to(0)
    expect(Reservation.count).to eq(0)
  end
end
