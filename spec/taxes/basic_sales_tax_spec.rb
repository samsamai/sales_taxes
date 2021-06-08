require 'taxes/basic_sales_tax'
require 'product'

RSpec.describe BasicSalesTax do
  describe '#percentage_rate' do
    describe 'for and exempt product' do
      before(:context) do
        @product = Product.new('test product', 1000, :food, false)
      end
      it 'returns 0.0' do
        basic = BasicSalesTax.new
        expect(basic.percentage_rate(@product)).to eq 0.0
      end
    end

    describe 'for and non-exempt produt' do
      before(:context) do
        @product = Product.new('test product', 1000, :other, false)
      end
      it 'returns 10.0' do
        basic = BasicSalesTax.new
        expect(basic.percentage_rate(@product)).to eq 10.0
      end
    end
  end
end
