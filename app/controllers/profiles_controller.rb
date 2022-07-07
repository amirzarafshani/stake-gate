class ProfilesController < ApplicationController
  before_action :authorize_request

  def index
    render json: current_user
  end
  
  def transactions
    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = current_user.user_transactions.paginate(page: page, per_page: per_page)
    total_items = items.size
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
