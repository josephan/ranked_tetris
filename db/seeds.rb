# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Match.destroy_all
User.destroy_all

u2 = User.create(name: "Stevens", email: "rip_stevens@thescore.com", elo: 10000, password: "123123")
u = User.create(name: "Joseph", email: "joseph@thescore.com", elo: 9000, password: "123123")
u = User.create(name: "Test", email: "test@test.com", elo: 9000, password: "123123")
User.create(name: "McKay", email: "mckay@thescore.com", elo: 8000, password: "123123")
User.create(name: "David", email: "david@thescore.com", elo: 7000, password: "123123")
User.create(name: "Aaron", email: "aaron@thescore.com", elo: 6000, password: "123123")
User.create(name: "Sacha", email: "sacha@thescore.com", elo: 5000, password: "123123")
User.create(name: "Kuba", email: "kuba@thescore.com", elo: 4000, password: "123123")

puts "#{User.count} users created!"
puts "#{Match.count} matches created!"
