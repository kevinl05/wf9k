# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ForecastsController, type: :controller do
  subject { described_class }

  describe 'actions' do
    context '#show' do
      let(:forecast) { create(:forecast) }

      before do
        get :show, params: { id: forecast.zip }
      end

      it { expect(response.status).to eq(200) }
    end

    context '#create' do
      context 'with valid address' do
        before do
          post :create, params: { forecast: { address: '1 Infinite Loop Cupertino, CA 95014 US' } }
        end

        it { expect(response.status).to eq(302) }
      end

      context 'with invalid address' do
        before do
          post :create, params: { forecast: { address: 'INVALID ADDRESS 9999999' } }
        end

        it { expect(response.status).to eq(302) }
      end
    end
  end
end
