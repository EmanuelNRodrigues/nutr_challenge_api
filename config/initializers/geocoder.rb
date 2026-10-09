Geocoder.configure(
  lookup: :nominatim,
  units: :km,
  http_headers: {
    "User-Agent" => "NutritionApp/1.0 #{ENV['GEOCODER_EMAIL']}"
  }
)
