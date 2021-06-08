# frozen_string_literal: true

require 'lineitem'

RSpec.describe Lineitem do
  describe '#initialize' do
    it 'creates new Lineitem and sets instance vars for valid attributes' do
      lineitem = Lineitem.new(1, 0, 1000)
      expect(lineitem.quantity).to eq 1
      expect(lineitem.product_id).to eq 0
      expect(lineitem.unit_price).to eq 1000
      expect(lineitem.total_price_inc_taxes).to eq nil
      expect(lineitem.total_taxes).to eq nil
    end
  end
end
