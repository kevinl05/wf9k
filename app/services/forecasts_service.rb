# frozen_string_literal: true

class ForecastsService
  attr_reader :error

  def initialize(params)
    @params = params
    address
    forecast if valid?
  end

  def call
    create_forecast unless @forecast || !valid?

    update_forecast if forecast_stale?
    @forecast
  end

  def valid?
    @error.blank?
  end

  private

  def forecast
    @forecast = Forecast.find_by(zip: @address.postal_code)
  end

  def forecast_stale?
    @forecast && @forecast.updated_at > (DateTime.now - 30.minutes)
  end

  def address
    @searched_address = Geocoder.search(@params[:address]).first

    if @searched_address.nil?
      @error = 'Could not find address, please try again.'
    elsif @searched_address&.postal_code&.nil?
      @address = Geocoder.search("#{@searched_address.data['lat']} #{@searched_address.data['lon']}").first
    else
      @address = @searched_address
    end
  end

  def create_forecast
    forecast_details

    @forecast = Forecast.create!(
      street: "#{@address.house_number} #{@address.street}",
      city: @address.city,
      state: @address.state,
      zip: @address.postal_code,
      current: @forecast_details.currently.temperature.round,
      high: @forecast_details.daily.data.first['temperatureMax'].round,
      low: @forecast_details.daily.data.first['temperatureMin'].round,
      conditions: @forecast_details.currently.summary,
      icon: @forecast_details.currently.icon
    )
  end

  def update_forecast
    forecast_details

    @forecast.update!(
      current: @forecast_details.currently.temperature.round,
      high: @forecast_details.daily.data.first['temperatureMax'].round,
      low: @forecast_details.daily.data.first['temperatureMin'].round,
      conditions: @forecast_details.currently.summary,
      icon: @forecast_details.currently.icon
    )
  end

  def forecast_details
    @forecast_details = ForecastIO.forecast(@address.data['lat'], @address.data['lon'])
  end
end
