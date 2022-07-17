class PlansController < ApplicationController

  # GET /plans
  def index
    @plans = Plan.order(:days)
    render json: @plans
  end
  
end
