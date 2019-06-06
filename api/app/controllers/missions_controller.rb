# frozen_string_literal: true

class MissionsController < ApplicationController
  def index
    render json: { missions: Mission.all }, status: :ok
  end
end
