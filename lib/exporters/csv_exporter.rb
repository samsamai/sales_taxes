# frozen_string_literal: true

require 'csv'
require 'utils'

# TxtExporter is responsible printing out the receipt to stdout
class CSVExporter
  def export(basket)
    CSV.generate(headers: true) do |csv|
      csv << ['Quantity', 'Product', 'Price(inc tax)']
      basket.lineitems.each do |li|
        csv << [
          li.quantity,
          li.product.name,
          li.total_price_inc_taxes / 100.0
        ]
      end
      csv << ['', '', '']
      csv << ['Sales Taxes:', nil, basket.total_taxes / 100.0]
      csv << ['Total:', nil, basket.total_inc_taxes / 100.0]
    end
  end
end
