# frozen_string_literal: true

class ForecastsService
  def initialize(params)
    @params = @params
    forecast
  end

  def call
    geocode_address
    forecast
    create_forecast unless @forecast
    update_forecast if forecast_stale?
    @forecast
  end

  private

  def forecast
    @forecast ||= Forecast.find_by(zip: @address.zip)
  end

  def forecast_stale?
    @forecast && @forecast.updated_at > (Time.now - 30.minutes)
  end

  def geocode_address
    @address ||= Geocoder.search(@params[:address]).first
  end

  def create_forecast
    forecast_details(@address.zip) unless @forecast

    Forecast.create(
      address: "#{@address.house_number} #{@address.road}",
      city: @address.city,
      state: @address.state,
      zip: @address.postcode,
      current: @forecast_details.currently.temperature.round,
      high: @forecast_details.daily.data.first["temperatureMax"].round,
      low: @forecast_details.daily.data.first["temperatureMin"].round,
      conditions: @forecast_details.currently.summary,
      icon: @forecast_details.icon
    )
  end

  def update_forecast
    forecast_details(@address.zip)

    @forecast.update(
      current: @forecast_details.currently.temperature.round,
      high: @forecast_details.daily.data.first["temperatureMax"].round,
      low: @forecast_details.daily.data.first["temperatureMin"].round,
      conditions: @forecast_details.currently.summary,
      icon: @forecast_details.icon
    )
  end

  def forecast_details(zip)
    @forecast_details ||= ForecastIO.forecast(@address.data["lat"], @address.data["long"])

  end
end
