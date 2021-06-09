# frozen_string_literal: true

# this class is reponsible for summing all the taxes
# applicable to the give product
class TaxesCalculator
  def initialize(taxes, tax_rounder)
    @taxes = taxes
    @tax_rounder = tax_rounder
  end

  def calculate(product, price)
    @taxes.sum(0) do |t|
      @tax_rounder.round_up(t.percentage_rate(product) / 100.0 * price)
    end
  end
end
