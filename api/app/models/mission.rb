# frozen_string_literal: true

class Mission < ApplicationRecord
  belongs_to :listing

  PRICES = {
    first_checkin: 10,
    checkout_checkin: 10,
    last_checkout: 5
  }.freeze
end
