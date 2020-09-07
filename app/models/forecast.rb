# frozen_string_literal: true

class Forecast < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  validates :zip, presence: true

  def address
    [street, city, state, 'US'].compact.join(', ')
  end
end
