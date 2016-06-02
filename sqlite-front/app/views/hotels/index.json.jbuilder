json.array!(@hotels) do |hotel|
  json.extract! hotel, :id, :name, :address, :stars, :accommodation
  json.url hotel_url(hotel, format: :json)
end
