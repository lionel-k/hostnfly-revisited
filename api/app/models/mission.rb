# frozen_string_literal: true

class Mission < ApplicationRecord
  PRICES = {
    first_checkin: 10,
    checkout_checkin: 10,
    last_checkout: 5
  }.freeze

  belongs_to :listing

  validates :date, :mission_type, :price, presence: true
  validates :mission_type, inclusion: { in: PRICES.keys.map(&:to_s),
                                        message: '%{value} is not a valid type' }

  def self.price_of(type)
    PRICES[type]
  end
end
