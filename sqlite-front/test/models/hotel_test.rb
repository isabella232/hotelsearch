require 'test_helper'

class HotelTest < ActiveSupport::TestCase

  test "search for hotel One" do
    hotels = Hotel.search(:q => "One")

    assert_equal( "Hotel One", hotels.first.name, "Should have found hotel One")
  end

  test "search for hotel by address" do
    hotels = Hotel.search(:q => "Waterfront")

    assert_equal( "Waterfront Ave", hotels.first.address, "Should have found Waterfront Ave hotel")
  end

  test "find all hotels" do
    hotels = Hotel.all.sort_by(&:name)

    assert_equal 2, hotels.size, "Should have found two hotels"
    assert_equal "Hotel One", hotels.first.name, "First hotel should be One"
    assert_equal "Hotel Two", hotels[1].name, "Second hotel should be Two"
  end

  test "find hotel by id" do
    hotel = Hotel.find_by_name("Hotel Two")
    found = Hotel.find(hotel.id)

    assert_equal "Hotel Two", found.name, "Should have found the proper hotel by the id"
  end

  test "create new hotel" do
    hotel = Hotel.new("name"=>"Hotel Three", "address"=>"Nice st", "stars"=>1, "accommodation"=>1)
    hotel.save

    found = Hotel.find_by_name("Hotel Three")

    assert_equal "Hotel Three", found.name , "Should have found the hotel Three"
  end

  test "delete hotel" do
    hotel = Hotel.find_by_name("Hotel Two")
    hotel.destroy

    assert_nil Hotel.find_by_name("Hotel Two"), "Should have been destroyed"
  end

end
