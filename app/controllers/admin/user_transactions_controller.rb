class Admin::UserTransactionsController < ApplicationController
  before_action :set_user_transaction, only: %i[ show update destroy ]

  # GET /user_transactions
  def index
    @user_transactions = UserTransaction.all
    render json: @user_transactions
  end

  # GET /user_transactions/1
  def show
    render json: @user_transaction
  end

  # POST /user_transactions
  def create
    @user_transaction = UserTransaction.new(user_transaction_params)

    if @user_transaction.save
      render json: @user_transaction, status: :created, location: @user_transaction
    else
      render json: @user_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_transactions/1
  def update
    if @user_transaction.update(user_transaction_params)
      render json: @user_transaction
    else
      render json: @user_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /user_transactions/1
  def destroy
    @user_transaction.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_transaction
      @user_transaction = UserTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_transaction_params
      params.require(:user_transaction).permit(:amount, :action, :status, :plan_id, :user_id)
    end
end
