# frozen_string_literal: true

class PublicController < ApplicationController
  def index
    @forecast = Forecast.new
  end
end
