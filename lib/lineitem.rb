# frozen_string_literal: true

require 'taxes/taxes_calculator'
require 'taxes/rounder'
require 'product'
require 'taxes/basic_sales_tax'
require 'taxes/import_tax'

# Lineitem class is reposible for keeping the details
# of a lineitem
class Lineitem
  attr_reader :quantity, :product, :unit_price, :unit_tax, :total_price_inc_taxes, :total_taxes

  def initialize(quantity, product, unit_price)
    @quantity = quantity
    @product = product
    @unit_price = unit_price * 100
    @total_price_inc_taxes = nil
    @total_taxes = nil

    taxes_calculator = TaxesCalculator.new(
      [BasicSalesTax.new, ImportTax.new],
      Rounder.new(5)
    )

    @unit_tax = taxes_calculator.calculate(@product)
    recalculate_totals
  end

  def recalculate_totals
    @total_taxes = quantity * @unit_tax
    @total_price_inc_taxes = quantity * @unit_price + @total_taxes
  end

  def quantity=(quantity)
    @quantity = quantity
    recalculate_totals
  end
end
