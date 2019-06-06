# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :listing

  after_create :generate_missions

  def generate_missions
    CreateCheckoutCheckinMissionService.new(reservation: self).call
  end

  def missions
    listing.missions.where(date: end_date)
  end

  def cancel
    missions.destroy_all
    destroy
  end
end
