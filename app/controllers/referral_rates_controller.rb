class ReferralRatesController < ApplicationController
  before_action :set_referral_rate, only: %i[ show update destroy ]

  # GET /referral_rates
  def index
    @referral_rates = ReferralRate.all

    render json: @referral_rates
  end

  # GET /referral_rates/1
  def show
    render json: @referral_rate
  end

  # POST /referral_rates
  def create
    @referral_rate = ReferralRate.new(referral_rate_params)

    if @referral_rate.save
      render json: @referral_rate, status: :created, location: @referral_rate
    else
      render json: @referral_rate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /referral_rates/1
  def update
    if @referral_rate.update(referral_rate_params)
      render json: @referral_rate
    else
      render json: @referral_rate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /referral_rates/1
  def destroy
    @referral_rate.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referral_rate
      @referral_rate = ReferralRate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def referral_rate_params
      params.require(:referral_rate).permit(:referral_count, :profit_rate)
    end
end
