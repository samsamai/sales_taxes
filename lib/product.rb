# frozen_string_literal: true

# Product class is responsible for storing
# the attributes of a product
# name - name of the product
# unit_price_cents - integer cost of 1 in cents excl taxes
# type - can be [:book, :food, :medical, :other]
# imported - boolean indicating if the product is an import
class Product
  attr_accessor :name, :unit_price, :type, :imported

  def initialize(name, unit_price, type, imported)
    @name = name
    @unit_price = unit_price
    @type = type
    @imported = imported
  end

  def self.id(name)
    PRODUCTS.index do |p|
      p.name == name
    end
  end
end

PRODUCTS = [
  Product.new('book', 1249, :book, false),
  Product.new('music cd', 1499, :other, false),
  Product.new('chocolate bar', 85, :food, false)
].freeze
