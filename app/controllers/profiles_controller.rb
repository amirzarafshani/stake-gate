class ProfilesController < ApplicationController
  before_action :authorize_request

  def index
    render json: {
      referral_code: current_user.referral_code,
      labels: current_user.assets.map {|asset| asset.created_at.strftime("%Y-%m-%d") },
      amounts: current_user.assets.map {|asset| asset.amount.to_i },
      profits: current_user.assets.map {|asset| asset.calculated_profit.to_i }
    }
  end

  def referrals
    render json: current_user.referrals
  end 
  
  def transactions
    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = current_user.user_transactions.paginate(page: page, per_page: per_page)
    total_items = current_user.user_transactions.size
    total_pages = (total_items.to_f / per_page).ceil

    render json: {
      items: items.as_json(
        include: { plan: { only: [:name, :days, :profit, :penalty]}}
      ),
      total_items: total_items,
      total_pages: total_pages
    }, status: :ok
  end

end
