# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MissionsController, type: :controller do
  let(:listings_attributes) do
    [
      { "id": 1, "num_rooms": 2 },
      { "id": 2, "num_rooms": 1 },
      { "id": 3, "num_rooms": 3 }
    ]
  end

  let(:bookings_attributes) do
    [
      { "id": 1, "listing_id": 1, "start_date": '2016-10-10', "end_date": '2016-10-15' },
      { "id": 2, "listing_id": 1, "start_date": '2016-10-16', "end_date": '2016-10-20' },
      { "id": 3, "listing_id": 2, "start_date": '2016-10-15', "end_date": '2016-10-20' }
    ]
  end

  let(:reservations_attributes) do
    [
      { "id": 1, "listing_id": 1, "start_date": '2016-10-11', "end_date": '2016-10-13' },
      { "id": 2, "listing_id": 1, "start_date": '2016-10-13', "end_date": '2016-10-15' },
      { "id": 3, "listing_id": 1, "start_date": '2016-10-16', "end_date": '2016-10-20' },
      { "id": 4, "listing_id": 2, "start_date": '2016-10-15', "end_date": '2016-10-18' }
    ]
  end

  describe 'GET #index' do
    it 'renders all missions' do
      Listing.create!(listings_attributes)
      Booking.create!(bookings_attributes)
      Reservation.create!(reservations_attributes)

      result = {
        "missions": [
          { listing_id: 1, mission_type: 'first_checkin', date: '2016-10-10', price: 20 },
          { listing_id: 1, mission_type: 'last_checkout', date: '2016-10-15', price: 10 },
          { listing_id: 1, mission_type: 'first_checkin', date: '2016-10-16', price: 20 },
          { listing_id: 1, mission_type: 'last_checkout', date: '2016-10-20', price: 10 },
          { listing_id: 1, mission_type: 'checkout_checkin', date: '2016-10-13', price: 20 },
          { listing_id: 2, mission_type: 'first_checkin', date: '2016-10-15', price: 10 },
          { listing_id: 2, mission_type: 'last_checkout', date: '2016-10-20', price: 5 },
          { listing_id: 2, mission_type: 'checkout_checkin', date: '2016-10-18', price: 10 }
        ]
      }

      get :index

      json = JSON.parse(response.body)
      clean = json['missions'].map do |item|
        item.delete('created_at')
        item.delete('updated_at')
        item.transform_keys!(&:to_sym)
      end
      expect(clean.size).to eq(result[:missions].size)
      expect(clean.map { |item| item[:listing_id] }.sort)
        .to eq(result[:missions].map { |item| item[:listing_id] }.sort)

      expect(clean.map { |item| item[:mission_type] }.sort)
        .to eq(result[:missions].map { |item| item[:mission_type] }.sort)

      expect(clean.map { |item| item[:date] }.sort)
        .to eq(result[:missions].map { |item| item[:date] }.sort)

      expect(clean.map { |item| item[:price] }.sort)
        .to eq(result[:missions].map { |item| item[:price] }.sort)
    end
  end
end
