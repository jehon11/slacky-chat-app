# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Message.destroy_all
User.destroy_all
Channel.destroy_all

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

names = %w(general random)
nicknames = %w(Tyrion Cersei Daenerys)

channels = names.map do |name|
  Channel.find_or_create_by(name: name)
end

users = nicknames.map do |nickname|
  User.create(email: "#{nickname.downcase}@slacky.com", nickname: nickname, password: "testtest")
end

10.times do
  random_user = users.sample
  Message.create!(user: random_user, channel: channels.sample, nickname: random_user.nickname, content: Faker::TvShows::GameOfThrones.quote)
end

puts 'Channels:'
channels.each do |channel|
  puts "- #{channel.id}: #{channel.name}"
end