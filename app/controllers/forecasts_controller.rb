# frozen_string_literal: true

class ForecastsController < ApplicationController
  def create
    @forecast = ::ForecastsService.new(forecast_params).call
    redirect_to(forecast_path(@forecast.zip))
  end

  def show
    @forecast = Forecast.find_by(zip: params[:id])
  end

  private

  def forecast_params
    params.require("forecast").permit("address")
  end
end
