# frozen_string_literal: true

require 'lineitem'

RSpec.describe Lineitem do
  describe '#initialize' do
    it 'creates new Lineitem and sets instance vars for valid attributes' do
      product = Product.new('imported luxury item', 1000, :other, true)

      lineitem = Lineitem.new(1, product, 10.0)
      expect(lineitem.quantity).to eq 1
      expect(lineitem.unit_price).to eq 1000
    end

    it 'it sets unit_tax from TaxesCalculator' do
      product = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem = Lineitem.new(2, product, 10_000.0)
      expect(lineitem.unit_tax).to eq 150_000
    end

    it 'it sets total_taxes' do
      product = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem = Lineitem.new(2, product, 10_000.0)
      expect(lineitem.total_taxes).to eq 300_000
    end

    it 'it sets total_price_inc_taxes' do
      product = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem = Lineitem.new(2, product, 10_000.0)
      expect(lineitem.total_price_inc_taxes).to eq 2_300_000
    end
  end
end
