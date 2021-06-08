require 'taxes/import_tax'
require 'product'

RSpec.describe ImportTax do
  describe '#percentage_rate' do
    describe 'for imported product' do
      before(:context) do
        @product = Product.new('test product', 1000, :other, true)
      end
      it 'returns 5.0' do
        basic = ImportTax.new
        expect(basic.percentage_rate(@product)).to eq 5.0
      end
    end

    describe 'for non-imported produt' do
      before(:context) do
        @product = Product.new('test product', 1000, :other, false)
      end
      it 'returns 0.0' do
        basic = ImportTax.new
        expect(basic.percentage_rate(@product)).to eq 0.0
      end
    end
  end
end
