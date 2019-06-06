# frozen_string_literal: true

class CreateLastCheckoutMissionService
  def initialize(attributes = {})
    @booking = attributes[:booking]
    @listing = @booking.listing
    @end_date = @booking.end_date
    @mission_type = :last_checkout
    @price = Mission::PRICES[@mission_type] * @listing.num_rooms
  end

  def call
    Mission.create!(listing: @listing,
                    mission_type: @mission_type,
                    date: @end_date,
                    price: @price)
  end
end
