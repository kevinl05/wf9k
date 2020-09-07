# frozen_string_literal: true

module ApplicationHelper
  def font_awesome_weather_icon(conditions)
    case conditions
    when 'clear-day'
      'sun'
    when 'clear-night'
      'moon'
    when 'rain'
      'cloud-rain'
    when 'snow'
      'snowflake'
    when 'sleet'
      'snowflake'
    when 'wind'
      'wind'
    when 'fog'
      'smog'
    when 'cloudy'
      'cloud'
    when 'partly-cloudy-day'
      'cloud-sun'
    when 'partly-cloudy-night'
      'cloud-moon'
    else
      'sun'
    end
  end

  def bootstrap_class_for flash_type
    {
      success: 'alert-success',
      error: 'alert-danger',
      alert: 'alert-warning',
      notice: 'alert-info'
    }.stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)}", role: 'alert') do
              concat content_tag(:button, 'x', class: 'close', data: { dismiss: 'alert' })
              concat message
        end
      )
    end

    nil
  end
end
