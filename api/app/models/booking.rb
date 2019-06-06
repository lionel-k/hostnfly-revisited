# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :listing

  validates :start_date, :end_date, presence: true
  validate :rental_period_valid?

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

  def rental_period_valid?
    return if [start_date.blank?, end_date.blank?].any?

    if start_date > end_date
      errors.add(:rental_period, 'start_date must earlier than end_date')
    end
  end

  def generate_missions
    CreateFirstCheckinMissionService.new(booking: self).call
    CreateLastCheckoutMissionService.new(booking: self).call
  end
end
