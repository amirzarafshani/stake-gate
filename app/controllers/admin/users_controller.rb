class Admin::UsersController < AdminController
  before_action :authorize_request
  before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    if params[:status]
      @users = @users.where(status: params[:status])
    end

    per_page = params[:per_page] ? params[:per_page] : 10
    page = params[:page] ? params[:page] : 1

    items = @users.paginate(page: page, per_page: per_page)
    total_items = @users.size
    total_pages = (total_items.to_f / per_page).ceil

    render json: {
      items: ActiveModelSerializers::SerializableResource.new(
        items,
        each_serializer: UserSerializer
      ),
      total_items: total_items,
      total_pages: total_pages
    }, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end


  # PUT /users/{username}
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :referral_code)
  end
end