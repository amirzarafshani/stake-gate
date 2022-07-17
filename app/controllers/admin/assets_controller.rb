class Admin::AssetsController < AdminController
  before_action :authorize_request
  before_action :set_asset, only: %i[ show update destroy ]
  # GET /assets
  def index
    @assets = Asset.all
    if params[:status]
      @assets = @assets.where(status: params[:status])
    end

    if params[:user_id]
      @assets = @assets.where(user_id: params[:user_id])
    end

    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = @assets.paginate(page: page, per_page: per_page)
    total_items = @assets.size
    total_pages = (total_items.to_f / per_page).ceil

    render json: {
      items: ActiveModelSerializers::SerializableResource.new(
        items,
        each_serializer: AssetSerializer
      ),
      total_items: total_items,
      total_pages: total_pages
    }, status: :ok
  end

  # GET /assets/1
  def show
    render json: @asset
  end

  # POST /assets
  def create
    @asset = Asset.new(asset_params)

    if @asset.save
      render json: @asset, status: :created
    else
      render json: @asset.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /assets/1
  def update
    if @asset.update(asset_params)
      render json: @asset
    else
      render json: @asset.errors, status: :unprocessable_entity
    end
  end

  # DELETE /assets/1
  def destroy
    @asset.destroy
  end

  private
    def set_asset
      @asset = Asset.find(params[:id])
    end

    def asset_params
      params.require(:asset).permit(:amount, :status, :plan_id, :user_id)
    end
end
