# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

hotels = []
hotels += Hotel.create([name: "Hotel One",address: "Market Street", stars: 5, accommodation: 5])
hotels += Hotel.create([name: "Hotel Two",address: "Waterfront Ave", stars: 1, accommodation: 1])
