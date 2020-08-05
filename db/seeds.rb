# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Review.delete_all
Idea.delete_all
User.delete_all


NUM_IDEAS = 100
NUM_USERS = 20
PASSWORD = "supersecret"


super_user = User.create(
  first_name: "Dua",
  last_name: "Lipa",
  email: "dl@winterfell.gov",
  password: PASSWORD
)


NUM_USERS.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name:  last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )

end

users = User.all

NUM_IDEAS.times do
  created_at = Faker::Date.backward(days: 365 * 4)
  f=Idea.create(
  title: Faker::Hacker.say_something_smart,
  body:  Faker::ChuckNorris.fact,
  created_at: created_at,
  updated_at: created_at,
  user: users.sample
 )
 if f.valid?
   f.reviews = rand(0..20).times.map do
     Review.new(
      body: Faker::GreekPhilosophers.quote,
      user: users.sample
     )
   end
 end
end

idea = Idea.all
review = Review.all

puts Cowsay.say("Generated #{idea.count} ideas", :turkey)
puts Cowsay.say("Generated #{review.count} reviews", :turtle)
puts Cowsay.say("Generated #{users.count} users", :frogs)

puts "Login with #{super_user.email} and password: #{PASSWORD}"
