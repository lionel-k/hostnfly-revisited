# frozen_string_literal: true

class CreateFirstCheckinMissionService
  def initialize(attributes = {})
    @booking = attributes[:booking]
    @listing = @booking.listing
    @start_date = @booking.start_date
    @mission_type = :first_checkin
    @price = Mission::PRICES[@mission_type] * @listing.num_rooms
  end

  def call
    Mission.create!(listing: @listing,
                    mission_type: @mission_type,
                    date: @start_date,
                    price: @price)
  end
end
