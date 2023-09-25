# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.delete_all
Friendship.delete_all

user = User.new
user.email = 'test@example.com'
user.password = 'testing'
user.save!

user = User.new
user.email = 'test1@example.com'
user.password = 'testing1'
user.save!

user = User.new
user.email = 'test2@example.com'
user.password = 'testing2'
user.save!

user2 = User.second
user2.friendships.build(friend_id: User.first.id, pending: true)
user2.save
