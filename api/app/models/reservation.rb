# frozen_string_literal: true

class Reservation < ApplicationRecord
  belongs_to :listing

  include ActiveModel::Validations
  validates_with RentalPeriodValidator

  validates :start_date, :end_date, presence: true

  after_create :generate_missions

  def missions
    listing.missions.where(date: end_date, mission_type: 'checkout_checkin')
  end

  def cancel
    missions.destroy_all
    destroy
  end

  private

  def generate_missions
    CreateCheckoutCheckinMissionService.new(reservation: self).call
  end
end
