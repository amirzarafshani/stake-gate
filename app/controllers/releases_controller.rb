class ReleasesController < ApplicationController
  before_action :authorize_request
  def index
    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = current_user.releases.paginate(page: page, per_page: per_page)
    total_items = current_user.releases.size
    total_pages = (total_items.to_f / per_page).ceil

    render json: {
      items: items.as_json,
      total_items: total_items,
      total_pages: total_pages
    }, status: :ok
  end

  def create
    ActiveRecord::Base.transaction do
      begin
        release = Release.new(release_params)
        release.user = current_user
        release.status = 0
        # decrement from asset's total amont
        asset = Asset.find(release.asset_id)
        # current amont in asset before request
        release.current_amount = asset.amount
        asset.status = "archived"
        release.remaining = asset.remaining
        release.elapsed = asset.elapsed
        asset.save!
        release.penalty  = asset.calculated_penalty
        release.profit  = calculated_profit(asset)
        release.save!
        render json: release.to_json
      rescue ActiveRecord::StatementInvalid
        render json: {}, status: :unprocessable_entity
      end
    end

  end

  private

  def release_params
    params.require(:release).permit(:amount, :protocol, :address, :asset_id)
  end
  
  def calculated_profit(asset)
    return 0 unless asset.elapsed
    return 0 unless asset.elapsed.to_i >= asset.plan.days
    profit = asset.elapsed * asset.amount.to_f * asset.plan.profit
    return profit
  end
end
