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

  def self.by_name(name)
    index = PRODUCTS.index do |p|
      p.name == name
    end
    return nil if index.nil?

    PRODUCTS[index]
  end
end

PRODUCTS = [
  Product.new('book', 1249, :book, false),
  Product.new('music cd', 1499, :other, false),
  Product.new('chocolate bar', 85, :food, false),
  Product.new('imported box of chocolates', 1000, :food, true),
  Product.new('imported bottle of perfume', 4750, :other, true),
  Product.new('bottle of perfume', 1899, :other, false),
  Product.new('packet of headache pills', 975, :medical, false)
].freeze
