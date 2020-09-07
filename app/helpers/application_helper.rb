# frozen_string_literal: true

module ApplicationHelper
  def font_awesome_weather_icon(conditions)
    case conditions
      when "clear-day"
        "sun"
      when "clear-night"
        "moon"
      when "rain"
        "cloud-rain"
      when "snow"
        "snowflake"
      when "sleet"
        "snowflake"
      when "wind"
        "wind"
      when "fog"
        "smog"
      when "cloudy"
        "cloud"
      when "partly-cloudy-day"
        "cloud-sun"
      when "partly-cloudy-night"
        "cloud-moon"
      else
        "sun"
    end
  end
end
