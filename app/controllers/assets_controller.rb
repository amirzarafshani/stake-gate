class AssetsController < ApplicationController
  before_action :authorize_request

  def index
    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = current_user.assets.paginate(page: page, per_page: per_page)
    total_items = current_user.assets.size
    total_pages = (total_items.to_f / per_page).ceil

    render json: {
      items: items.as_json(
        include: { plan: { only: [:name, :days, :profit, :penalty]}}
      ),
      total_items: total_items,
      total_pages: total_pages
    }, status: :ok
  end

  def create
    asset = Asset.create(
      amount: params[:amount],
      transaction_id: params[:transaction_id],
      status: 'pending',
      plan_id: params[:plan_id],
      image: params[:image],
      user_id: current_user.id,
    )
    render json: asset
  end

  private

  def asset_params
    params.require(:asset).permit(:amount, :action, :image, :status, :transaction_id, :plan_id)
  end
end
