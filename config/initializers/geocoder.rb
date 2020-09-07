Geocoder.configure(
  # Geocoding options
  timeout: 3,                   # geocoding service timeout (secs)
  language: :en,                # ISO-639 language code
  use_https: true,              # use HTTPS for lookup requests? (if supported)
  api_key: Rails.application.credentials.geocoder_api_key,
  cache_prefix: 'geocoder:',    # prefix (string) to use for all cache keys

  # Calculation options
  units: :mi,                   # :km for kilometers or :mi for miles
  distances: :linear            # :spherical or :linear
)
