# frozen_string_literal: true

require 'csv'
require 'lineitem'
require 'product'

# CSVImporter is responsible parsing a CSV
# and returning an array of lineitems
class CSVImporter
  def import(csv_string)
    csv = CSV.new(csv_string, headers: :first_row, return_headers: false)
    lineitems = []
    csv.to_a.each do |row|
      product_id = Product.id(row[1].strip)
      next if product_id.nil?

      lineitems << Lineitem.new(row[0].to_i, product_id, PRODUCTS[product_id].unit_price)
    end

    lineitems
  end
end
