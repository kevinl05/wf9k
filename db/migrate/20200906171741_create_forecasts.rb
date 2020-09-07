# frozen_string_literal: true

class CreateForecasts < ActiveRecord::Migration[5.2]
  def change
    create_table :forecasts do |t|
      t.decimal :high
      t.decimal :low
      t.decimal :current
      t.text :conditions
      t.integer :zip
      t.string :icon

      t.timestamps
    end
  end
end
