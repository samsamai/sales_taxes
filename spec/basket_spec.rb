# frozen_string_literal: true

require 'basket'
require 'product'
require 'lineitem'

RSpec.describe Basket do
  describe '#initialize' do
    it 'creates new Basket with no lineitems' do
      basket = Basket.new
      expect(basket.lineitems).to eq []
    end
  end

  describe '#add_lineitem' do
    it 'adds a lineitem to the basket' do
      basket = Basket.new
      expect(basket.lineitems.count).to eq 0

      product = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem = Lineitem.new(2, product)
      basket.add_lineitem(lineitem)

      expect(basket.lineitems.count).to eq 1
    end
  end

  describe '#recalculate' do
    it 'sums total_taxes and total_inc_taxes for all its lineitems' do
      basket = Basket.new

      expect(basket).to receive(:recalculate).twice.and_call_original
      product1 = Product.new('imported luxury item', 1_000_000, :other, true)
      lineitem1 = Lineitem.new(1, product1)
      basket.add_lineitem(lineitem1)

      product2 = Product.new('non-exempt item', 1_000_000, :other, false)
      lineitem2 = Lineitem.new(1, product2)
      basket.add_lineitem(lineitem2)

      expect(basket.total_taxes).to eq 250_000
      expect(basket.total_inc_taxes).to eq 2_250_000
    end
  end
end
