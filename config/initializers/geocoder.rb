Geocoder.configure(
  timeout: 5,                                   # geocoding service timeout (secs)
  lookup: :mapbox,                              # name of geocoding service (symbol)
  api_key: ENV['MAPBOX_API_KEY'],               # API key for geocoding service
  units: :km,                                   # :km for kilometers or :mi for miles
)
