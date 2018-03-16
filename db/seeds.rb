# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u = User.create(name: "Joseph", email: "joseph@thescore.com", elo: 1500)
u2 = User.create(name: "Stevens", email: "ripstevens@thescore.com", elo: 3000)

Match.create(player_one: u, player_two: u2, winner: u2)
