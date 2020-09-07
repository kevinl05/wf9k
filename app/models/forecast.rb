class Forecast < ApplicationRecord
  geocoded_by :address
  after_validation :geocode

  def address
    [street, city, state, 'US'].compact.join(', ')
  end
end
