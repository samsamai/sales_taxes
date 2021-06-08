# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  describe '#initialize' do
    it 'creates new Product and sets instance vars for valid attributes' do
      product = Product.new('test product', 1000, :food, false)
      expect(product.name).to eq 'test product'
      expect(product.unit_price).to eq 1000
      expect(product.type).to eq :food
      expect(product.imported).to eq false
    end
  end
end
