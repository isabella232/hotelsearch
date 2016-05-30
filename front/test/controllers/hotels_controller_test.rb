require 'test_helper'
require 'rspec/mocks'

class HotelsControllerTest < ActionController::TestCase

  setup do
    RSpec::Mocks::setup(self)
    @hotel = Hotel.new({:id => 1, name => "test"})
  end

  test "should get index" do
    allow(Hotel).to receive(:get).and_return(@hotel)
    get :index
    assert_response :success
    assert_not_nil assigns(:hotels)
  end
  #
  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end
  #
  # test "should show hotel" do
  #   get :show, id: @hotel
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get :edit, id: @hotel
  #   assert_response :success
  # end
  #
  # test "should update hotel" do
  #   patch :update, id: @hotel, hotel: { accomodation_type: @hotel.accomodation_type, address: @hotel.address, name: @hotel.name, star_rating: @hotel.star_rating }
  #   assert_redirected_to hotel_path(assigns(:hotel))
  # end
  #
  # test "should destroy hotel" do
  #   assert_difference('Hotel.count', -1) do
  #     delete :destroy, id: @hotel
  #   end
  #
  #   assert_redirected_to hotels_path
  # end
end
