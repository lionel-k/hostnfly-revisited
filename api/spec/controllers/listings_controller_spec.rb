# frozen_string_literal: true

require "rails_helper"

RSpec.describe ListingsController, type: :controller do
  let(:valid_attributes) do
    [
      { num_rooms: 2 },
      { num_rooms: 1 },
      { num_rooms: 3 }
    ]
  end

  describe 'GET #index' do
    it 'renders all listings' do
      Listing.create!(valid_attributes)

      get :index

      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end
  end

  describe 'POST #create' do
    it 'creates a listing with valid data' do
      post :create,
           params:
                 {
                  listing: valid_attributes.first
                 }

      json = JSON.parse(response.body)
      expect(json['num_rooms']).to eq(2)
      expect(response).to have_http_status(200)
      expect(Listing.count).to eq(1)
    end
  end

  describe 'PUT #update' do
    it 'updates data of a given listing' do
      listing = Listing.create!(valid_attributes.first)

      put 'update', params: { id: listing.id, listing: { num_rooms: 20 } }

      json = JSON.parse(response.body)
      expect(json['num_rooms']).to eq(20)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy a listing' do
      listing = Listing.create!(valid_attributes.first)
      listing_id = listing.id

      delete 'destroy', params: { id: listing_id }

      expect(response.body).to be_empty
      expect(response).to have_http_status(204)
      expect(Listing.ids).not_to include listing_id
    end
  end

  describe 'GET #show' do
    it 'displays a listing' do
      listing = Listing.create!(valid_attributes.first)

      get 'show', params: { id: listing.id }

      json = JSON.parse(response.body)
      expect(json['num_rooms']).to eq(2)
      expect(response).to have_http_status(200)
    end
  end
end
