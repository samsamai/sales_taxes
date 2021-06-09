# frozen_string_literal: true

require 'utils'

# TxtExporter is responsible for formating the receipt into txt
class TxtExporter
  def export(basket)
    output = basket.lineitems.map do |li|
      "#{li.quantity}, #{li.product.name}, #{currency_format(li.total_price_inc_taxes / 100.0)}\n"
    end.join

    totals = <<~TOTALS

      Sales Taxes: #{currency_format(basket.total_taxes / 100.0)}
      Total: #{currency_format(basket.total_inc_taxes / 100.0)}
    TOTALS

    output + totals
  end
end
