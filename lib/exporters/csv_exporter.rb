# frozen_string_literal: true

require 'csv'
require 'utils'

# TxtExporter is responsible printing out the receipt to stdout
class CSVExporter
  def export(basket)
    CSV.generate(headers: true) do |csv|
      csv << ['Quantity', 'Product', 'Price(inc tax)']
      basket.lineitems.each { |li| csv << row_as_array(li) }
      csv << ['', '', '']
      csv << ['Sales Taxes:', nil, basket.total_taxes / 100.0]
      csv << ['Total:', nil, basket.total_inc_taxes / 100.0]
    end
  end

  private

  def row_as_array(lineitem)
    [
      lineitem.quantity,
      lineitem.product.name,
      lineitem.total_price_inc_taxes / 100.0
    ]
  end
end
