# frozen_string_literal: true

FactoryBot.define do
  factory :forecast do
    street { '1 Infinite Loop' }
    city { 'Cupertino' }
    state { 'CA' }
    zip { 95_014 }
    high { 90.0 }
    low { 80.0 }
    current { 75.0 }
    icon { 'clear-day' }
    conditions { 'Clear' }
    latitude { 37.3316697 }
    longitude { -122.030098202155 }
  end
end
