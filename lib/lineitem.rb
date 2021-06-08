# frozen_string_literal: true

# Lineitem class is reposible for keeping the details
# of a lineitem
class Lineitem
  attr_accessor :quantity, :product_id, :unit_price, :total_price_inc_taxes, :total_taxes

  def initialize(quantity, product_id, unit_price)
    @quantity = quantity
    @product_id = product_id
    @unit_price = unit_price
    @total_price_inc_taxes = nil
    @total_taxes = nil
  end
end
