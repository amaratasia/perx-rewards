# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(email: 'amaratasia@gmail.com', dob: '27-01-2000')
Order.create(user: user)

Reward.create name: "Free Movie", format: 'movie'
Reward.create name: "Free Cofee", format: 'coffee'
Reward.create name: "5% Reba", format: 'rebate', config: { percentage: 5 }