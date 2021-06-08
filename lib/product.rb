# frozen_string_literal: true

# Product class is responsible for storing
# the attributes of a product
# name - name of the product
# unit_price_cents - integer cost of 1 in cents excl taxes
# type - can be [:book, :food, :medical, :other]
# imported - boolean indicating if the product is an import
class Product
  attr_accessor :name, :unit_price_cents, :type, :imported

  def initialize(name, unit_price_cents, type, imported)
    @name = name
    @unit_price_cents = unit_price_cents
    @type = type
    @imported = imported
  end
end
