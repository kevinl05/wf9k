# frozen_string_literal: true

class ForecastsService
  def initialize(params)
    @params = params
    address
    forecast
  end

  def call
    create_forecast unless @forecast
    update_forecast if forecast_stale?
    @forecast
  end

  private

  def forecast
    @forecast = Forecast.find_by(zip: @address.postal_code)
  end

  def forecast_stale?
    @forecast && @forecast.updated_at < (Time.now - 30.minutes)
  end

  def address
    @searched_address = Geocoder.search(@params[:address]).first

    if @searched_address.postal_code.nil?
      @address = Geocoder.search("#{@searched_address.data["lat"]} #{@searched_address.data["lon"]}").first
    else
      @address = @searched_address
    end
  end

  def create_forecast
    forecast_details(@address.postal_code )

    @forecast = Forecast.create!(
      street: "#{@address.house_number} #{@address.street}",
      city: @address.city,
      state: @address.state,
      zip: @address.postal_code,
      current: @forecast_details.currently.temperature.round,
      high: @forecast_details.daily.data.first["temperatureMax"].round,
      low: @forecast_details.daily.data.first["temperatureMin"].round,
      conditions: @forecast_details.currently.summary,
      icon: @forecast_details.currently.icon
    )
  end

  def update_forecast
    forecast_details(@address.postal_code)

    @forecast.update!(
      current: @forecast_details.currently.temperature.round,
      high: @forecast_details.daily.data.first["temperatureMax"].round,
      low: @forecast_details.daily.data.first["temperatureMin"].round,
      conditions: @forecast_details.currently.summary,
      icon: @forecast_details.currently.icon
    )
  end

  def forecast_details(zip)
    @forecast_details = ForecastIO.forecast(@address.data["lat"], @address.data["lon"])
  end
end
