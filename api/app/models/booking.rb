# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :listing

  after_create :generate_missions

  def missions
    listing.missions.where(date: [start_date, end_date])
  end

  def cancel
    missions.destroy_all
    destroy
  end

  private

  def generate_missions
    CreateFirstCheckinMissionService.new(booking: self).call
    CreateLastCheckoutMissionService.new(booking: self).call
  end

  def create_last_checkout_mission; end
end
