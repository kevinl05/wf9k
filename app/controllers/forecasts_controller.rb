# frozen_string_literal: true

class ForecastsController < ApplicationController
  def create
    @forecast = ForecastsService.new(forecast_params).call

    redirect_to @forecast
  end

  def show
    @forecast = Forecast.find_by(id: params[:zip])
  end

  private

  def forecast_params
    params.permit(:address)
  end
end
