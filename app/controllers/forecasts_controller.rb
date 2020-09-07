# frozen_string_literal: true

class ForecastsController < ApplicationController
  def create
    service = ForecastsService.new(forecast_params)
    @forecast = service.call

    if service.valid?
      redirect_to(forecast_path(@forecast.zip))
    else
      flash[:alert] = service.error
      redirect_to root_path
    end
  end

  def show
    @forecast = ForecastsService.new(address: params[:id]).call
  end

  private

  def forecast_params
    params.require("forecast").permit("address")
  end
end
