# frozen_string_literal: true

require 'basket'
require 'product'
require 'lineitem'
require 'importers/csv_importer'
require 'exporters/txt_exporter'

RSpec.describe Basket do
  before(:context) do
    @importer = CSVImporter.new
    @exporter = TxtExporter.new
  end

  describe '#initialize' do
    it 'creates new Basket with no lineitems' do
      basket = Basket.new(@importer, @exporter)
      expect(basket.lineitems).to eq []
    end
  end

  describe '#add_lineitem' do
    it 'adds a lineitem to the basket' do
      basket = Basket.new(@importer, @exporter)
      expect(basket.lineitems.count).to eq 0

      product = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem = Lineitem.new(2, product, 10_000.0)
      basket.add_lineitem(lineitem)

      expect(basket.lineitems.count).to eq 1
    end
  end

  describe '#recalculate' do
    it 'sums total_taxes and total_inc_taxes for all its lineitems' do
      basket = Basket.new(@importer, @exporter)

      expect(basket).to receive(:recalculate).twice.and_call_original
      product1 = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem1 = Lineitem.new(1, product1, 10_000.0)
      basket.add_lineitem(lineitem1)

      product2 = Product.new('non-exempt item', 1_000_000, :other, false)
      lineitem2 = Lineitem.new(1, product2, 10_000.0)
      basket.add_lineitem(lineitem2)

      expect(basket.total_taxes).to eq 250_000
      expect(basket.total_inc_taxes).to eq 2_250_000
    end
  end

  describe '#import' do
    it 'imports lines items as csv' do
      csv_data = <<~CSV
        Quantity, Product, Price
        1, book, 12.49
        10, music cd, 14.99
      CSV

      basket = Basket.new(@importer, @exporter)
      expect(basket.lineitems.count).to eq 0

      basket.import(csv_data)
      expect(basket.lineitems.count).to eq 2
    end

    it 'recalculates totals after import' do
      csv_data = <<~CSV
        Quantity, Product, Price
        1, music cd, 10.00
      CSV

      basket = Basket.new(@importer, @exporter)
      expect(basket.total_inc_taxes).to eq nil
      expect(basket.total_taxes).to eq nil

      basket.import(csv_data)
      expect(basket.total_inc_taxes).to eq 1100
      expect(basket.total_taxes).to eq 100
    end
  end

  describe '#export' do
    before(:context) do
      @importer = CSVImporter.new
      @exporter = TxtExporter.new
    end

    it 'calls the export method of the exporter' do
      basket = Basket.new(@importer, @exporter)

      product1 = Product.new('imported luxury item', 5000, :other, true)
      lineitem1 = Lineitem.new(1, product1, 50.0)
      basket.add_lineitem(lineitem1)

      product2 = Product.new('non-exempt item', 1000, :other, false)
      lineitem2 = Lineitem.new(1, product2, 10.0)
      basket.add_lineitem(lineitem2)

      expect(basket.exporter).to receive(:export).with(basket).once.and_call_original

      expect { basket.export }.to output.to_stdout
    end

    it 'does not output anything with empty lineitems list' do
      basket = Basket.new(@importer, @exporter)
      expect { basket.export }.not_to output.to_stdout
    end
  end

  describe 'basket integration test (input -> output)' do
    before(:context) do
      importer = CSVImporter.new
      exporter = TxtExporter.new
      @basket = Basket.new(importer, exporter)
    end

    it 'is correct for Input 1 test data' do
      input_data = <<~CSV
        Quantity, Product, Price
        1, book, 12.49
        1, music cd, 14.99
        1, chocolate bar, 0.85
      CSV

      @basket.import(input_data)

      expected_output = <<~OUTPUT
        1, book, 12.49
        1, music cd, 16.49
        1, chocolate bar, 0.85

        Sales Taxes: 1.50
        Total: 29.83
      OUTPUT

      expect { @basket.export }.to output(expected_output).to_stdout
    end

    it 'is correct for Input 2 test data' do
      input_data = <<~CSV
        Quantity, Product, Price
        1, imported box of chocolates, 10.00
        1, imported bottle of perfume, 47.50
      CSV

      @basket.import(input_data)

      expected_output = <<~OUTPUT
        1, imported box of chocolates, 10.50
        1, imported bottle of perfume, 54.65

        Sales Taxes: 7.65
        Total: 65.15
      OUTPUT

      expect { @basket.export }.to output(expected_output).to_stdout
    end

    it 'is correct for Input 2 test data' do
      input_data = <<~CSV
        Quantity, Product, Price
        1, imported bottle of perfume, 27.99
        1, bottle of perfume, 18.99
        1, packet of headache pills, 9.75
        1, imported box of chocolates, 11.25
      CSV

      @basket.import(input_data)

      expected_output = <<~OUTPUT
        1, imported bottle of perfume, 32.19
        1, bottle of perfume, 20.89
        1, packet of headache pills, 9.75
        1, imported box of chocolates, 11.85

        Sales Taxes: 6.70
        Total: 74.68
      OUTPUT

      expect { @basket.export }.to output(expected_output).to_stdout
    end
  end
end
