# frozen_string_literal: true

class Mission < ApplicationRecord
  PRICES = {
    first_checkin: 10,
    checkout_checkin: 10,
    last_checkout: 5
  }.freeze

  belongs_to :listing

  before_validation :compute_price

  validates :date, :mission_type, :price, presence: true
  validates :mission_type, inclusion: { in: PRICES.keys.map(&:to_s),
                                        message: '%{value} is not a valid type' }

  def self.price_of(type)
    if PRICES.keys.include? type
      PRICES[type]
    else
      0
    end
  end

  def compute_price
    unless mission_type.nil?
      self.price = Mission.price_of(mission_type.to_sym) * listing.num_rooms
    end
  end
end
