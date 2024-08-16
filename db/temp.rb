require "nokogiri"
require "open-uri"

url = "https://giftlife.tokyo/awd/rental" # the url of the web page you want to scrape
html = URI.open(url) # open the html of the page
doc = Nokogiri::HTML.parse(html) # create a nokogiri doc based on that html

# names = []
# name_elements = doc.search(".ec-productItemRole__title")
# name_elements.first(5).each do |element|
#   names << element.text.strip
# end

urls = []
urls_elements = doc.search(".ec-productItemRole__image a")
urls_elements.first(5).each do |element|
  urls << element.attribute("href").value
end

image_urls = []
urls.each do |url|
  html2 = URI.open(url) # open the html of the page
  doc2 = Nokogiri::HTML.parse(html2) # create a nokogiri doc based on that html


  name_element = doc2.search(".ec-productRole__title h1")
  name_array = name_element.text.strip.split(" ", 2)

  image_elements = doc2.search(".ec-productVisualNav img")
  image_elements.first(5).each do |element|
    prefix = "https://giftlife.tokyo/"
    image_urls << "#{prefix}#{element.attribute("src").value}"
  end

  car = Car.create!(
    brand: name_array[0],
    model: name_array[1],
    year: Faker::Vehicle.year,
    rate: Faker::Commerce.price(range: 500..1500),
    user: User.all.sample,
    description: Faker::Vehicle.car_options )

  index = 0
  image_urls.each do |link|
    index = 0
    p file = URI.open(link)
    car.photos.attach(io: file, filename: "#{name_element.text.strip}#{index.to_s}.jpg", content_type: "image/png")
    # lambo2.photos.attach(io: lambo_file, filename: "Lambo#{index.to_s}.jpg", content_type: "image/png")
    index += 1
  end
  car.save

end


# names_and_urls = names.zip(urls).flatten.compact.each_slice(2).to_a
# names_urls_preptime = names_and_urls.zip(prep_times).flatten.compact.each_slice(3).to_a
# names_urls_pretime_ratings = names_urls_preptime.zip(ratings).flatten.compact.each_slice(4).to_a
# # Parse the HTML document to extract the first 5 recipes suggested and store them in an Array
# recipe_array = []
# names_urls_pretime_ratings.each do |parameters|
#   recipe_array << Recipe.new(*parameters)
# end
