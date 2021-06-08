# frozen_string_literal: true

require 'product'

# ImportTax class is concerned with imported products
# Its percentage_rate method returns the percentage tax rate
# according to the imported status of the product
class ImportTax
  def initialize(rate = 5.0)
    @rate = rate
  end

  def percentage_rate(product)
    return 0.0 unless product.imported

    @rate
  end
end
