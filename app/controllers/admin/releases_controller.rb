class Admin::ReleasesController < AdminController
  before_action :authorize_request
  before_action :set_release, only: %i[ show update destroy ]
  # GET /releases
  def index
    @releases = Release.all
    if params[:status]
      @releases = @releases.where(status: params[:status])
    end

    if params[:user_id]
      @releases = @releases.where(user_id: params[:user_id])
    end
    
    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = @releases.paginate(page: page, per_page: per_page)
    total_items = @releases.size
    total_pages = (total_items.to_f / per_page).ceil

    render json: {
      items: items.as_json,
      total_items: total_items,
      total_pages: total_pages
    }, status: :ok
  end

  # GET /releases/1
  def show
    render json: @release
  end

  # POST /releases
  def create
    @release = Release.new(release_params)

    if @release.save
      render json: @release, status: :created
    else
      render json: @release.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /releases/1
  def update
    if @release.update(release_params)
      if @release.rejected?
        @release.asset.update(status: :done)
      end
      render json: @release
    else
      render json: @release.errors, status: :unprocessable_entity
    end
  end

  # DELETE /releases/1
  def destroy
    @release.destroy
  end

  private
    def set_release
      @release = Release.find(params[:id])
    end

    def release_params
      params.require(:release).permit(:amount, :status, :plan_id, :user_id, :transaction_id)
    end
end
