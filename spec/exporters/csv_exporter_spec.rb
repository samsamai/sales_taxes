# frozen_string_literal: true

require 'exporters/csv_exporter'
require 'basket'
require 'product'
require 'lineitem'

RSpec.describe CSVExporter do
  describe 'export' do
    before(:context) do
      @exporter = CSVExporter.new
    end

    it 'prints out receipt' do
      basket = Basket.new

      product1 = Product.new('imported luxury item', 5000, :other, true)
      lineitem1 = Lineitem.new(1, product1, 50.0)
      basket.add_lineitem(lineitem1)

      product2 = Product.new('non-exempt item', 1000, :other, false)
      lineitem2 = Lineitem.new(1, product2, 10.0)
      basket.add_lineitem(lineitem2)

      actual = @exporter.export(basket)

      expect(actual).to include('Quantity,Product,Price(inc tax)')
      expect(actual).to include('1,imported luxury item,57.5')
      expect(actual).to include('1,non-exempt item,11.0')
      expect(actual).to include('Sales Taxes:,,8.5')
      expect(actual).to include('Total:,,68.5')
    end
  end
end
