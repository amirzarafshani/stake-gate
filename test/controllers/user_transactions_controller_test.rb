require "test_helper"

class UserTransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_transaction = user_transactions(:one)
  end

  test "should get index" do
    get user_transactions_url, as: :json
    assert_response :success
  end

  test "should create user_transaction" do
    assert_difference("UserTransaction.count") do
      post user_transactions_url, params: { user_transaction: { action: @user_transaction.action, amount: @user_transaction.amount, plan_id: @user_transaction.plan_id, status: @user_transaction.status, user_id: @user_transaction.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show user_transaction" do
    get user_transaction_url(@user_transaction), as: :json
    assert_response :success
  end

  test "should update user_transaction" do
    patch user_transaction_url(@user_transaction), params: { user_transaction: { action: @user_transaction.action, amount: @user_transaction.amount, plan_id: @user_transaction.plan_id, status: @user_transaction.status, user_id: @user_transaction.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy user_transaction" do
    assert_difference("UserTransaction.count", -1) do
      delete user_transaction_url(@user_transaction), as: :json
    end

    assert_response :no_content
  end
end
