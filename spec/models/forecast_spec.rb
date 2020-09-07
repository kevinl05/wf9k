# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Forecast, type: :model do
  it { is_expected.to validate_presence_of(:zip) }

  describe 'methods' do
    context '#address' do
      let(:forecast) { create(:forecast) }

      it { expect(forecast.address).to eq('1 Infinite Loop, Cupertino, CA, US') }
    end
  end
end
