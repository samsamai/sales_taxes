# frozen_string_literal: true

require 'importers/csv_importer'
require 'product'

RSpec.describe CSVImporter do
  describe '#import' do
    before(:context) do
      @importer = CSVImporter.new
    end

    it 'creates lineitem for single row' do
      csv_data = <<~CSV
        Quantity, Product, Price
        1, book, 12.49
      CSV
      actual = @importer.import(csv_data)
      product_id = Product.id('book')

      expect(actual.count).to eq 1
      li = actual[0]
      expect(li.quantity).to eq 1
      expect(li.product_id).to eq product_id
      expect(li.unit_price).to eq 1249
    end

    it 'creates lineitems for 2 rows' do
      csv_data = <<~CSV
        Quantity, Product, Price
        1, book, 12.49
        10, music cd, 14.99
      CSV
      product1_id = Product.id('book')
      product2_id = Product.id('music cd')

      actual = @importer.import(csv_data)
      expect(actual.count).to eq 2

      li1 = actual[0]
      expect(li1.quantity).to eq 1
      expect(li1.product_id).to eq product1_id

      li2 = actual[1]
      expect(li2.quantity).to eq 10
      expect(li2.product_id).to eq product2_id
    end

    it 'returns [] if product not found for single row data' do
      csv_data = <<~CSV
        Quantity, Product, Price
        1, unknown product, 12.49
      CSV
      actual = @importer.import(csv_data)

      expect(actual.count).to eq 0
    end

    fit 'ignores the header' do
      csv_data = <<~CSV
        Quantity, book, Price
        1, book, 12.49
      CSV
      actual = @importer.import(csv_data)

      expect(actual.count).to eq 1
    end
  end
end
