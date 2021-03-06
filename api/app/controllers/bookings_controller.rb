# frozen_string_literal: true

class BookingsController < ApplicationController
  def index
    render_json(Booking.where(listing: listing))
  end

  def create
    booking = listing.bookings.create!(booking_params)
    render_json(booking)
  end

  def update
    booking.update(booking_params)
    render_json(booking)
  end

  def show
    render_json(booking)
  end

  def destroy
    booking.cancel
    head :no_content
  end

  private

  def booking
    listing.bookings.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def listing
    Listing.find(params[:listing_id])
  end

  def render_json(item)
    render json: item, status: :ok
  end
end
