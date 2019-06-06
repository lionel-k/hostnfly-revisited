# frozen_string_literal: true

class ListingsController < ApplicationController
  def index
    render_json(Listing.all)
  end

  def create
    render_json(Listing.create!(listing_params))
  end

  def update
    listing.update!(listing_params)
    render_json(listing)
  end

  def destroy
    listing.destroy!
    head :no_content
  end

  def show
    render_json(listing)
  end

  private

  def listing
    Listing.find(params[:id])
  end

  def listing_params
    params.require(:listing).permit(:num_rooms)
  end

  def render_json(item)
    render json: item, status: :ok
  end
end
