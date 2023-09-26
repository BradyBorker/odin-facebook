# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.delete_all
Friendship.delete_all

User.create(
    email: 'testing@example.com',
    password: 'testing',
    user_information_attributes:
        {
            first_name: 'test',
            last_name: '0'
        }
)

User.create(
    email: 'testing1@example.com',
    password: 'testing',
    user_information_attributes:
        {
            first_name: 'test',
            last_name: '1'
        }
)

User.create(
    email: 'testing2@example.com',
    password: 'testing',
    user_information_attributes:
        {
            first_name: 'test',
            last_name: '2'
        }
)

user2 = User.second
user2.friendships.build(friend_id: User.first.id, pending: true)
user2.save
