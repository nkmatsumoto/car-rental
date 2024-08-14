require "faker"
require "open-uri"

puts "Cleaning the DB..."
Booking.destroy_all
Car.destroy_all
User.destroy_all

# CATEGORIES = %W[burger ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

user_count = 6

puts "Creating #{user_count} users and cars..."

brands = {
  Porsche: "GT3RS",
  Lamborghini: "Huracan",
  Ferrari: "Laferrari",
  Bugatti: "Chiron",
  McLaren: "P1",
  Tesla: "Roadster",
}

user_count.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    address: Faker::Address.city
  )
end





# User.all.each do |user|
#   # brand_sample = brands.sample
#   # make = Faker::Vehicle.make
#   # model = Faker::Vehicle.model(make_of_model: brand_sample)
#   make = brands.sample
#   model = Faker::Vehicle.model(make_of_model: make)
#   p file = URI.open("https://loremflickr.com/320/240/#{make},#{model}")

#   car = Car.create!(
#   brand: make,
#   model: model,
#   year: Faker::Vehicle.year,
#   rate: Faker::Commerce.price(range: 50..500),
#   user: user,
#   description: Faker::Vehicle.car_options )
#   car.photo.attach(io: file, filename: "#{model}.jpg", content_type: "image/png")
#   car.save
# end

brands.each do |brand, model|
  p file = URI.open("https://loremflickr.com/320/240/#{brand},#{model}")

  car = Car.create!(
  brand: brand,
  model: model,
  year: Faker::Vehicle.year,
  rate: Faker::Commerce.price(range: 50..500),
  user: User.all.sample,
  description: Faker::Vehicle.car_options )
  car.photo.attach(io: file, filename: "#{model}.jpg", content_type: "image/png")
  car.save
end

p lambo_file = URI.open("https://images.pexels.com/photos/6462662/pexels-photo-6462662.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2")

lambo = Car.create!(
  brand: "Lamborghini",
  model: "Huracan",
  year: 2022,
  rate: Faker::Commerce.price(range: 50..500),
  user: User.all.sample,
  description: Faker::Vehicle.car_options )
  lambo.photo.attach(io: lambo_file, filename: "Lamborghini.jpg", content_type: "image/png")
  lambo.save

User.all.each do |user|
  2.times do
  Booking.create(
    user: user,
    car: Car.where.not(id: user.cars).sample,
    start_date: Date.today - rand(1..10),
    end_date: Date.today + rand(1..10),
  )
  end
end



# User.create!(
#   content: Faker::Restaurant.review,
#   rating: rand(2..5),
#   restaurant: restaurant)


puts "... created #{user_count} users and cars"
