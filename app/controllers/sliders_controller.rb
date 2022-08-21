class SlidersController < ApplicationController
  def index
    @sliders = Slider.order(:sort)
    render json: @sliders
  end
end
