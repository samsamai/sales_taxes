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

      expect(actual.count).to eq 1
      li = actual[0]
      expect(li.quantity).to eq 1
      expect(li.unit_price).to eq 1249
    end

    it 'creates lineitems for 2 rows' do
      csv_data = <<~CSV
        Quantity, Product, Price
        1, book, 12.49
        10, music cd, 14.99
      CSV
      product1 = Product.by_name('book')
      product2 = Product.by_name('music cd')

      actual = @importer.import(csv_data)
      expect(actual.count).to eq 2

      li1 = actual[0]
      expect(li1.quantity).to eq 1
      expect(li1.product).to eq product1

      li2 = actual[1]
      expect(li2.quantity).to eq 10
      expect(li2.product).to eq product2
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

  describe '#quantity=' do
    it 'changes the quantity and recalculates totals' do
      product = Product.new('book', 1249, :book, true)
      lineitem = Lineitem.new(1, product, 12.49)
      expect(lineitem).to receive(:recalculate_totals)

      lineitem.quantity = 2

      expect(lineitem.quantity).to eq 2
    end

    describe '#recalculate_totals' do
      it 'sets total_taxes and total_price_inc_taxes' do
        product = Product.new('book', 1249, :book, true)
        lineitem = Lineitem.new(1, product, 12.49)
        expect(lineitem.total_taxes).to eq 65
        expect(lineitem.total_price_inc_taxes).to eq 1314

        lineitem.quantity = 2

        expect(lineitem.total_taxes).to eq 130
        expect(lineitem.total_price_inc_taxes).to eq 2628
      end
    end
  end
end
