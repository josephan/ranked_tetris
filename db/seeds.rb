# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Match.destroy_all

u2 = User.create(name: "Stevens (RIP)", email: "stevens@thescore.com", elo: 10000)
u = User.create(name: "Joseph", email: "joseph@thescore.com", elo: 9000)
User.create(name: "McKay", email: "mckay@thescore.com", elo: 8000)
User.create(name: "Thorney", email: "thorney@thescore.com", elo: 7000)
User.create(name: "Gough", email: "gough@thescore.com", elo: 6000)
User.create(name: "Sacha", email: "sacha@thescore.com", elo: 5000)
User.create(name: "Kuba", email: "kuba@thescore.com", elo: 4000)

Match.create(player_one: u, player_two: u2, winner: u2)
