# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :listing

  validates :start_date, :end_date, presence: true
  include ActiveModel::Validations
  validates_with RentalPeriodValidator

  after_create :generate_missions

  def missions
    listing
      .missions
      .where(date: [start_date, end_date],
             mission_type: ['first_checkin', 'last_checkout'])
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
end
