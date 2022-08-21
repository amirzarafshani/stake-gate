require "test_helper"

class ReferralRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @referral_rate = referral_rates(:one)
  end

  test "should get index" do
    get referral_rates_url, as: :json
    assert_response :success
  end

  test "should create referral_rate" do
    assert_difference("ReferralRate.count") do
      post referral_rates_url, params: { referral_rate: { profit_rate: @referral_rate.profit_rate, referral_count: @referral_rate.referral_count } }, as: :json
    end

    assert_response :created
  end

  test "should show referral_rate" do
    get referral_rate_url(@referral_rate), as: :json
    assert_response :success
  end

  test "should update referral_rate" do
    patch referral_rate_url(@referral_rate), params: { referral_rate: { profit_rate: @referral_rate.profit_rate, referral_count: @referral_rate.referral_count } }, as: :json
    assert_response :success
  end

  test "should destroy referral_rate" do
    assert_difference("ReferralRate.count", -1) do
      delete referral_rate_url(@referral_rate), as: :json
    end

    assert_response :no_content
  end
end
