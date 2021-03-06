# frozen_string_literal: true

# Basket class is responsible keeping track of the lineitems,
# recalculating its totals, setting off imports and exports
class Basket
  attr_reader :lineitems, :total_inc_taxes, :total_taxes, :importer, :exporter

  def initialize(importer, exporter)
    @importer = importer
    @exporter = exporter
    @lineitems = []
    @total_inc_taxes = nil
    @total_taxes = nil
  end

  def add_lineitem(lineitem)
    @lineitems << lineitem
    recalculate
  end

  def recalculate
    @total_inc_taxes = 0
    @total_taxes = 0
    @lineitems.each do |li|
      @total_taxes += li.total_taxes
      @total_inc_taxes += li.total_price_inc_taxes
    end
  end

  def import(csv_data)
    @lineitems = @importer.import(csv_data)
    recalculate
  end

  def export
    return if @lineitems.empty?

    $stdout.puts @exporter.export(self)
  end
end
