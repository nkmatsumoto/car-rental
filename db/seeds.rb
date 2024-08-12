require "faker"

puts "Cleaning the DB..."
Car.destroy_all
User.destroy_all

# CATEGORIES = %W[burger ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

# car_amount = 50
user_amount = 10

puts "Creating #{user_amount} users and cars..."


user_amount.times do
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    address: Faker::Address.city
  )

  Car.create(
  brand: Faker::Vehicle.make,
  model: Faker::Vehicle.model,
  year: Faker::Vehicle.year,
  rate: Faker::Commerce.price(range: 50..500),
  user: user,
  description: Faker::Vehicle.car_options )
end

# User.create!(
#   content: Faker::Restaurant.review,
#   rating: rand(2..5),
#   restaurant: restaurant)


puts "... created #{user_amount} users and cars"
