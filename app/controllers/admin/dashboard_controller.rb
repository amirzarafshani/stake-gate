class Admin::DashboardController < AdminController
  before_action :authorize_request
  before_action :set_plan, only: %i[ show update destroy ]

  def index
    render json: {
      user_count: User.count,
      asset_count: Asset.where(status: :pending)&.count,
      release_count: Release.where(status: :pending)&.count,
      chart_data: {
        labels: Asset.all.map {|asset| asset.created_at.strftime("%Y-%m-%d") },
        amounts: Asset.all.map {|asset| asset.amount.to_i },
        profits: Asset.all.map {|asset| asset.calculated_profit.to_i }
      }
    }
  end

end