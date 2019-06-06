# frozen_string_literal: true

class ReservationsController < ApplicationController
  def index
    render_json(Reservation.where(listing: listing))
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.listing = listing
    reservation.save!
    render_json(reservation)
  end

  def update
    reservation.update(reservation_params)
    render_json(reservation)
  end

  def show
    render_json(reservation)
  end

  def destroy
    reservation.cancel
    head :no_content
  end

  private

  def reservation
    Reservation.where(listing: listing, id: params[:id]).first
  end

  def reservation_params
    params.require(:reservation).permit(:start_date, :end_date)
  end

  def listing
    Listing.find(params[:listing_id])
  end

  def render_json(item)
    render json: item, status: :ok
  end
end
