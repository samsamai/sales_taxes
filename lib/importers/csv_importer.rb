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
      product = Product.by_name(row[1].strip)
      next if product.nil?

      lineitems << Lineitem.new(row[0].to_i, product, row[2].to_f)
    end

    lineitems
  end
end
