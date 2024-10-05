require "faker"
require "open-uri"
require "nokogiri"

puts " "
puts "Cleaning the DB..."
Booking.destroy_all
Car.destroy_all
User.destroy_all

cities = [
  "Tokyo",
  "Sapporo",
  "Fukuoka",
  "Osaka",
  "Kyoto",
  "Sendai",
  "Saitama",
  "Kobe",
]
puts " "
puts "Creating users accounts for Chae, Ryo and Nick..."

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

user_count = 10
puts " "
puts "Creating #{user_count} random users..."

user_count.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 8),
    address: cities.sample
  )
end

url = "https://www.tokyosupercars.com/rentals-lineup" # the url of the web page you want to scrape

puts " "
puts "scrapping data from #{url}"
html = URI.open(url) # open the html of the page
doc = Nokogiri::HTML.parse(html) # create a nokogiri doc based on that html

# names = []
# name_elements = doc.search(".ec-productItemRole__title")
# name_elements.first(5).each do |element|
#   names << element.text.strip
# end

urls = []
# urls_elements = doc.search(".comp-lm51gzru.FubTgk a")
urls_elements = doc.search(".comp-lm495jn0.YzqVVZ a")

p urls_elements.count
urls_elements.first(19).each do |element|
  urls << element.attribute("href").value
end

image_urls = []
urls.each do |url|
  begin
    html2 = URI.open(url) # open the html of the page
  rescue OpenURI::HTTPError
    next
  end
  doc2 = Nokogiri::HTML.parse(html2) # create a nokogiri doc based on that html

  name_element = doc2.at("h1")
  p name_array = name_element.text.strip.split(" ", 2)

  image_elements = doc2.search(".thumbnailItem")
  image_elements.first(5).each do |element|
    prefix = "https://static.wixstatic.com/media/"
    middle = element.attribute("data-key").value
    middle.insert(-8, '~')
    suffix = "/v1/fill/w_1594,h_956,q_90/"
    ending = element.attribute("data-key").value
    image_urls << "#{prefix}#{middle}#{suffix}#{ending}"
  end

  puts " "
  puts "creating car: #{name_element.text.strip}"
  car = Car.create!(
    brand: name_array[0],
    model: name_array[1],
    year: Faker::Vehicle.year,
    rate: Faker::Commerce.price(range: 500..1500),
    user: User.all.sample,
    description: Faker::Vehicle.car_options )

  index = 0
  image_urls.each do |link|
    p link
    begin
     p file = URI.open(link) # open the html of the page
    rescue OpenURI::HTTPError
      next
    end
    car.photos.attach(io: file, filename: "#{name_element.text.strip}#{index.to_s}.jpg", content_type: "image/png")
    index += 1
  end
  car.save
  image_urls = []
end


# names_and_urls = names.zip(urls).flatten.compact.each_slice(2).to_a
# names_urls_preptime = names_and_urls.zip(prep_times).flatten.compact.each_slice(3).to_a
# names_urls_pretime_ratings = names_urls_preptime.zip(ratings).flatten.compact.each_slice(4).to_a
# # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
# recipe_array = []
# names_urls_pretime_ratings.each do |parameters|
#   recipe_array << Recipe.new(*parameters)
# end


# brands = {
#   Porsche: "CarreraS",
#   Lamborghini: "Huracan",
#   Ferrari: "Laferrari",
#   RollsRoyce: "Cullinan",
#   McLaren: "P1",
#   Nissan: "GTR",
#   Audi: "R8",
#   Mercedes: "G-wagon",
# }


lambo = Car.create!(
  brand: "Lamborghini",
  model: "Huracan",
  year: 2022,
  rate: Faker::Commerce.price(range: 500..1500),
  user: User.find_by(email: "stuntpad@gmail.com"),
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
    index += 1
  end

  lambo.save

puts " "
puts "... created #{User.all.count} users and #{Car.all.count} cars"
