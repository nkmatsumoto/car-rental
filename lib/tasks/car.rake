namespace :car do
  desc "TODO"
  task scrape: :environment do
    require 'nokogiri'
    require 'open-uri'
    require 'fileutils'

    # URL of the website to scrape
    url = 'https://www.tokyosupercars.com/rentals-lineup'

    # Open the website and parse it with Nokogiri
    doc = Nokogiri::HTML(URI.open(url))

    # Create a directory to store images
    FileUtils.mkdir_p('db/images')

    # Find image tags and download them
    doc.css('img').each_with_index do |img, index|
      image_url = img['src']

      # Skip if the image URL is incomplete
      next unless image_url

      # Handle relative URLs
      image_url = URI.join(url, image_url).to_s

      # Open the image URL and save it locally
      File.open("db/images/image_#{index}.jpg", 'wb') do |f|
        f.write(URI.open(image_url).read)
      end
    end
    puts "Images scraped and saved in db/images directory."
  end
end
