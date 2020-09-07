# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForecastsService, type: :service do
  describe 'call' do
    context 'when forecast is stale' do
      let(:fourty_five_minutes_ago) { DateTime.now - 45.minutes }
      let(:apple_address) { '1 Infinite Loop Cupertino, CA, US' }
      let(:forecast) { create(:forecast, updated_at: fourty_five_minutes_ago) }

      before do
        described_class.new(address: apple_address.call)
      end

      it 'updates the forecast' do
        expect(forecast.updated_at).not_to eq(Forecast.take.updated_at)
      end
    end

    context 'when address does not exist' do
      let(:service) { described_class.new(address: 'FAILING ADDRESS') }
      let(:result) { service.call }

      it 'returns an error' do
        expect(service.error).to eq('Could not find address, please try again.')
      end
    end

    context 'when address exists but no zip code' do
      let(:service) { described_class.new(address: 'Kansas City, MO, US') }
      let(:result) { service.call }

      it 'returns an error' do
        expect(service.error).to be_nil
      end
    end

    context 'when forecast does not exist' do
      it { expect { described_class.new(address: apple_address).call }.to change(Forecast, :count).from(0).to(1) }
    end
  end
end
