# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Asset.destroy_all
User.destroy_all
Plan.destroy_all

User.create(email: "user@gmail.com", password: 'password')
Plan.create(name: "one", days: 30, profit: 40, penalty: 12, plan_type: "fixed")
Plan.create(name: "two", days: 60, profit: 69, penalty: 12, plan_type: "fixed")
Plan.create(name: "three", days: 90, profit: 77, penalty: 12, plan_type: "fixed")
Plan.create(name: "four", days: 0, profit: 11, penalty: 0, plan_type: "flexible")

20.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: "password",
    referrer_id: [nil, User.first.id].sample
  )

  12.times do
    user.assets.create!(
      amount: Faker::Number.between(from: 100, to: 99999),
      plan: Plan.all.sample,
      status: [0,2,1].sample
    )
  end
end