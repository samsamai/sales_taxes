# frozen_string_literal: true

require 'product'

# ImportTax class is concerned with imported products
# Its percentage_rate method returns the percentage tax rate
# according to the imported status of the product
class ImportTax
  def initialize(product)
    @product = product
  end

  def percentage_rate
    return 0.0 unless @product.imported

    5.0
  end
end
