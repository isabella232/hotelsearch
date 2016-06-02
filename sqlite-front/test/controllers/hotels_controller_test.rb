require 'test_helper'

class HotelsControllerTest < ActionController::TestCase
  setup do
    @hotel = hotels(:one)
  end

  test "should search" do
    post :search, q: "Ave"
    assert_response :success
    assert_select 'td:nth-child(2)', 'Hotel Two'
  end

  test "should search for Ave with json result" do
    post :search, :format => :json, :q => "Ave"
    assert_response :success
    body = JSON.parse(response.body)

    assert_equal "Waterfront Ave", body.first["address"], "Waterfront Ave should be in the json response"
  end

  test "search should return no match" do
    post :search, :format => :json, :q => "Ave1111111"
    assert_response :success
    body = JSON.parse(response.body)

    assert body.empty?
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hotels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hotel" do
    assert_difference('Hotel.count') do
      post :create, hotel: { accommodation: @hotel.accommodation, address: @hotel.address, name: @hotel.name, stars: @hotel.stars }
    end

    assert_redirected_to hotel_path(assigns(:hotel))
  end

  test "should show hotel" do
    get :show, id: @hotel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @hotel
    assert_response :success
  end

  test "should update hotel" do
    patch :update, id: @hotel, hotel: { accommodation: @hotel.accommodation, address: @hotel.address, name: @hotel.name, stars: @hotel.stars }
    assert_redirected_to hotel_path(assigns(:hotel))
  end

  test "should destroy hotel" do
    assert_difference('Hotel.count', -1) do
      delete :destroy, id: @hotel
    end

    assert_redirected_to hotels_path
  end
end
