# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:listing) do
    Listing.create!(num_rooms: 2)
  end

  let(:valid_attributes) do
    {
      start_date: '2016-10-10',
      end_date: '2016-10-15'
    }
  end

  describe 'GET #index' do
    it 'renders all bookings' do
      listing.bookings.create!(valid_attributes)

      get :index, params: { listing_id: listing.id }

      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end
  end

  describe 'POST #create' do
    it 'creates a booking with valid data' do
      post :create,
           params:
                 {
                  listing_id: listing.id,
                  booking: valid_attributes
                 }

      json = JSON.parse(response.body)
      expect(json['start_date']).to eq('2016-10-10')
      expect(json['end_date']).to eq('2016-10-15')
      expect(response).to have_http_status(200)
      expect(Booking.count).to eq(1)
    end
  end

  describe 'PUT #update' do
    it 'updates data of a given booking' do
      booking = listing.bookings.create!(valid_attributes)

      put 'update',
          params:
          {
            listing_id: listing.id,
            id: booking.id,
            booking: { end_date: '2016-10-22' }
          }

      json = JSON.parse(response.body)
      expect(json['end_date']).to eq('2016-10-22')
      expect(booking.reload.end_date).to eq(Date.parse('2016-10-22'))
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy a booking' do
      booking = listing.bookings.create!(valid_attributes)
      booking_id = booking.id

      delete 'destroy',
             params: { listing_id: listing.id,
                       id: booking.id }

      expect(response.body).to be_empty
      expect(response).to have_http_status(204)
      expect(Booking.ids).not_to include booking_id
    end
  end

  describe 'GET #show' do
    it 'displays a booking' do
      booking = listing.bookings.create!(valid_attributes)

      get 'show', params: { listing_id: listing.id,
                            id: booking.id }

      json = JSON.parse(response.body)
      expect(json['start_date']).to eq('2016-10-10')
      expect(json['end_date']).to eq('2016-10-15')
      expect(json['listing_id']).to eq(listing.id)
      expect(response).to have_http_status(200)
    end
  end
end
