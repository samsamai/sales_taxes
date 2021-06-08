# frozen_string_literal: true

require 'taxes/taxes_calculator'
require 'taxes/rounder'
require 'product'
require 'taxes/basic_sales_tax'
require 'taxes/import_tax'

RSpec.describe TaxesCalculator do
  describe '#calculate' do
    before(:context) do
      @rounder = Rounder.new(5)
      @basic_tax = BasicSalesTax.new
      @import = ImportTax.new
    end

    it 'return 15.0 (sums of basic and import tax) for an imported luxury item' do
      product = Product.new('imported luxury item', 1000, :other, true)

      taxes_calculator = TaxesCalculator.new([@basic_tax, @import], @rounder)
      expect(taxes_calculator.calculate(product)).to eq 150
    end

    it 'return 0.0 for non-imported food item' do
      product = Product.new('local food item', 1000, :food, false)

      taxes_calculator = TaxesCalculator.new([@basic_tax, @import], @rounder)
      expect(taxes_calculator.calculate(product)).to eq 0.0
    end

    it 'return 5.0 for imported food item' do
      product = Product.new('local food item', 1000, :food, true)

      taxes_calculator = TaxesCalculator.new([@basic_tax, @import], @rounder)
      expect(taxes_calculator.calculate(product)).to eq 50
    end

    it 'return 10.0 for non-imported non-exempt item' do
      product = Product.new('local food item', 1000, :other, false)

      taxes_calculator = TaxesCalculator.new([@basic_tax, @import], @rounder)
      expect(taxes_calculator.calculate(product)).to eq 100
    end
  end
end
