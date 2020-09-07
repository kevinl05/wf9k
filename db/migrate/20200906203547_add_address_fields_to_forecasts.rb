class AddAddressFieldsToForecasts < ActiveRecord::Migration[5.2]
  def change
    add_column :forecasts, :street, :string
    add_column :forecasts, :city, :string
    add_column :forecasts, :state, :string
    add_column :forecasts, :latitude, :decimal
    add_column :forecasts, :longitude, :decimal

    add_index :forecasts, :zip
  end
end
