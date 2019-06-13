# frozen_string_literal: true

class CreateCheckoutCheckinMissionService
  def initialize(attributes = {})
    @reservation = attributes[:reservation]
    @listing = @reservation.listing
    @mission_type = :checkout_checkin
    @end_date = @reservation.end_date
  end

  def call
    existing_last_checkout = Mission
                             .where(listing: @listing,
                                    mission_type: 'last_checkout',
                                    date: @end_date).exists?

    unless existing_last_checkout
      Mission.create!(listing: @listing,
                      mission_type: @mission_type,
                      date: @end_date)
    end
  end
end
