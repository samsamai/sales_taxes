# frozen_string_literal: true

require 'product'

# BasicSalesTax class knows about the product types
# that need to be taxed
# Its percentage_rate method returns the percentage tax rate
# according to the type of the product
class BasicSalesTax
  EXEMPT_TYPES = %i[book food medical].freeze

  def initialize(rate = 10.0)
    @rate = rate
  end

  def percentage_rate(product)
    return 0.0 if EXEMPT_TYPES.include? product.type

    @rate
  end
end
