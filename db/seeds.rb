require "faker"
require "open-uri"

puts "Cleaning the DB..."
Booking.destroy_all
Car.destroy_all
User.destroy_all

# CATEGORIES = %W[burger ramen sushi desserts healthy kebabs pizza tacos sandwiches dumplings soup curry rice pasta steakhouse vegan bakery juice salads seafood brunch wings cafe bbq deli pies buffet pub brasserie shakes creamery grill]

user_count = 7

puts "Creating #{user_count} users and cars..."

brands = {
  Porsche: { model: "Laferrari", photo_url: "db/images/image_53.jpg" },
  Lamborghini: "Huracan",
  Ferrari: { model: "Laferrari", photo_url: "db/images/image_2.jpg" },
  RollsRoyce: { model: "Cullinan", photo_url: "db/images/image_4.jpg" },
  McLaren: { model: "P1", photo_url: "db/images/image_4.jpg" },
  Nissan: { model: "GTR", photo_url: "db/images/image_47.jpg" },
  Audi: { model: "R8", photo_url: "db/images/image_55.jpg" },
  Mercedes: { model: "G-wagon", photo_url: "db/images/image_57.jpg" },
}

user_count.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    address: Faker::Address.city
  )

  brands.each do |brand, info|
    Car.create(
      user: user,
      make: brand.to_s,
      model: info[:model],
      photo_url: info[:photo_url]  # Use the mapped photo_url
    )
  end
end


User.create!(
  first_name: "Nicholas",
  last_name: "Matsumoto",
  email: "nk.matsumoto@gmail.com",
  password: "password",
  address: "Meguro"
)

User.create!(
  first_name: "Chaewan",
  last_name: "Shin",
  email: "chaewanshin@gmail.com",
  password: "password",
  address: "Tokyo"
)
User.create!(
  first_name: "Ryo",
  last_name: "Imaoka",
  email: "stuntpad@gmail.com",
  password: "password",
  address: "Tokyo"
)
# User.all.each do |user|
#   # brand_sample = brands.sample
#   # make = Faker::Vehicle.make
#   # model = Faker::Vehicle.model(make_of_model: brand_sample)
#   make = brands.sample
#   model = Faker::Vehicle.model(make_of_model: make)
#   p file = URI.open("https://loremflickr.com/320/240/#{make},#{model}")

#   car = Car.create!(
#   brand: brand,
#   model: model,
#   year: Faker::Vehicle.year,
#   rate: Faker::Commerce.price(range: 50..500),
#   user: User.all.sample,
#   description: Faker::Vehicle.car_options )
#   car.photos.attach(io: file, filename: "#{model}.jpg", content_type: "image/png")
#   car.save
# end


# lambo2 = Car.create!(
#   brand: "Lamborghini",
#   model: "Huracan",
#   year: 2022,
#   rate: Faker::Commerce.price(range: 50..500),
#   user: User.all.sample,
#   description: Faker::Vehicle.car_options )

lambo = Car.create!(
  brand: "Lamborghini",
  model: "Huracan",
  year: 2022,
  rate: Faker::Commerce.price(range: 50..500),
  user: User.find_by(email: "nk.matsumoto@gmail.com"),
  description: Faker::Vehicle.car_options )


  lambo_img_link = [
    "https://images.pexels.com/photos/6462662/pexels-photo-6462662.png?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
    "https://www.carbodydesign.com/media/2014/02/Lamborghini-Aventador-Roadster-Interior-Ad-Personam-personalization-program-01.jpg",
    "https://media.istockphoto.com/id/1418456581/photo/details-of-stylish-car-interior-leather-interior.jpg?s=612x612&w=0&k=20&c=moBwB-v_pCAky6fCGconSAZEBuu9nGF912I8yWhuO-s=",
    "https://cdn.motor1.com/images/mgl/A80qL/s1/4x3/2014-lamborghini-veneno-roadster-sold-at-auction-for-nearly-8-3-million.webp",
    "https://www.mclarencf.com/imagetag/280/5/l/Used-2022-Lamborghini-Huracan-EVO-RWD.jpg",
  ]
  index = 0
  lambo_img_link.each do |link|
    index = 0
    p lambo_file = URI.open(link)
    lambo.photos.attach(io: lambo_file, filename: "Lamborghini#{index.to_s}.jpg", content_type: "image/png")
    # lambo2.photos.attach(io: lambo_file, filename: "Lambo#{index.to_s}.jpg", content_type: "image/png")
    index += 1
  end

  lambo.save



# User.all.each do |user|
#   2.times do
#   Booking.create(
#     user: user,
#     car: Car.where.not(id: user.cars).sample,
#     start_date: Date.today - rand(1..10),
#     end_date: Date.today + rand(1..10),
#   )
#   end
# end


# User.create!(
#   content: Faker::Restaurant.review,
#   rating: rand(2..5),
#   restaurant: restaurant)


puts "... created #{user_count} users and cars"




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
