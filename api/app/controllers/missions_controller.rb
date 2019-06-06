# frozen_string_literal: true

class MissionsController < ApplicationController
  def index
    render json: Mission.order(:listing_id), status: :ok
  end
end
