ForecastIO.configure do |configuration|
  configuration.api_key = Rails.application.credentials.forecast_io_api_key
end
