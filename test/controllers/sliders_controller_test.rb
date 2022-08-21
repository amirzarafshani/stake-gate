require "test_helper"

class SlidersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slider = sliders(:one)
  end

  test "should get index" do
    get sliders_url, as: :json
    assert_response :success
  end

  test "should create slider" do
    assert_difference("Slider.count") do
      post sliders_url, params: { slider: { image: @slider.image, name: @slider.name, sort: @slider.sort } }, as: :json
    end

    assert_response :created
  end

  test "should show slider" do
    get slider_url(@slider), as: :json
    assert_response :success
  end

  test "should update slider" do
    patch slider_url(@slider), params: { slider: { image: @slider.image, name: @slider.name, sort: @slider.sort } }, as: :json
    assert_response :success
  end

  test "should destroy slider" do
    assert_difference("Slider.count", -1) do
      delete slider_url(@slider), as: :json
    end

    assert_response :no_content
  end
end
