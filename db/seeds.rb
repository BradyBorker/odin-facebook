# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.delete_all

emails = ['test1@gmail.com', 'test2@gmail.com', 'test3@gmail.com', 'test4@gmail.com']
emails.each do |email|
    user = User.new(email: email)
    user.save
end