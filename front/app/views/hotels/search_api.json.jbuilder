json.array! @hotels do |h|
  json.id h.id
  json.name h.name
  json.address h.address
  json.searchableText h.searchableText
  json.star_rating h.star_rating
  json.accomodation_type h.accomodation_type
end
