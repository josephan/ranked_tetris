# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Match.destroy_all
User.destroy_all

u = User.create(name: 'Joseph', email: 'joseph@thescore.com', elo: 2000, password: '123123')
u2 = User.create(name: 'Jonathan', email: 'test@test.com', elo: 2000, password: '123123', admin: true)
u3 = User.create(name: 'McKay', email: 'mckay@thescore.com', elo: 2000, password: '123123')
u4 =User.create(name: 'David', email: 'david@thescore.com', elo: 2000, password: '123123')
User.create(name: 'Aaron', email: 'aaron@thescore.com', elo: 2000, password: '123123')
User.create(name: 'Sacha', email: 'sacha@thescore.com', elo: 2000, password: '123123')
User.create(name: 'Kuba', email: 'kuba@thescore.com', elo: 2000, password: '123123')
User.create(name: 'Ryan', email: 'ryan.wang@thescore.com', elo: 1000, password: '123123', retired: true)
User.create(name: 'Nic', email: 'nic@thescore.com', elo: 1000, password: '123123', retired: true)
User.create(name: 'Albert', email: 'albert@thescore.com', elo: 1000, password: '123123', retired: true)
User.create(name: 'Stevens', email: 'stevens@thescore.com', elo: 1000, password: '123123', retired: true)

time = Time.zone.now
# confirmed matches
(0..10).each do |i|
  Match.create!(created_at: time + i.minute, updated_at: time + i.minute, winner_id: nil, player_one: u, player_two: u2, player_one_elo_delta: 10, player_two_elo_delta: -10, player_one_rounds_won: 3, player_two_rounds_won: 1)
end
# unconfirmed matches
(0..20).each do |i|
  Match.create!(created_at: time + i.minute, updated_at: time + i.minute, winner_id: u.id, player_one: u, player_two: u2, player_one_elo_delta: 10, player_two_elo_delta: -10, player_one_rounds_won: 3, player_two_rounds_won: 1)
end


(0..3).each do |_i|
  Match.create!(winner_id: u3.id, player_one: u3, player_two: u4, player_one_elo_delta: 10, player_two_elo_delta: -10, player_one_rounds_won: 3, player_two_rounds_won: 1, created_at: 2.weeks.ago, updated_at: 2.weeks.ago)
end

(0..3).each do |_i|
  Match.create!(winner_id: u4.id, player_one: u4, player_two: u3, player_one_elo_delta: 10, player_two_elo_delta: -10, player_one_rounds_won: 3, player_two_rounds_won: 1, created_at: 2.weeks.ago, updated_at: 2.weeks.ago)
end

puts "#{User.count} users created!"
puts "#{Match.count} matches created!"
