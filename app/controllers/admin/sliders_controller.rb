class Admin::SlidersController < AdminController
  before_action :set_slider, only: %i[ show update destroy ]

  # GET /sliders
  def index
    @sliders = Slider.all

    render json: @sliders
  end

  # GET /sliders/1
  def show
    render json: @slider
  end

  # POST /sliders
  def create
    @slider = Slider.new(slider_params)

    if @slider.save
      render json: @slider, status: :created
    else
      render json: @slider.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /sliders/1
  def update
    if @slider.update(slider_params)
      render json: @slider
    else
      render json: @slider.errors, status: :unprocessable_entity
    end
  end

  # DELETE /sliders/1
  def destroy
    @slider.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slider
      @slider = Slider.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def slider_params
      params.permit(:name, :image, :sort)
    end
end
