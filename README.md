# Sales Taxes

This is a solution to the Sales Taxes problem using the Ruby programming language.

## Design & Coding

In order to solve this problem I read the brief a number of times and looked for the main objects in this domain. The objects that I settled on were: basket, line item, exporter, importer, tax calculator, basic sales tax, import tax, rounder and product.
With my objects named, I tried to organize them in such a way that the system could easily be extended without having to change a lot of objects. I made the following list of things that could change with the system in the future:

- a new tax type is introduced
- a new rounding algorithm needs to be added
- a new importer needed
- a new exporter needed

With these possible changes in mind I tried to create a system where the objects had specific responsibilities and didn't do many unrelated tasks. I tried to used Dependency Inversion where I could, to make higher level modules rely on abstractions rather than concrete classes. For example all importer classes implement an `import` method, the high level module (Basket) doesn't care what sort of importer it is dealing with as long as it has the `import` method that it can call and get back a list of line items.

The code has been written using Test Driven Development starting with some of the low level modules with few or no dependencies so the system could be build up step by step. Rspec was used for testing with Guard giving constant feedback and Rubocop pointing out improvements.

Assumptions: I assumed that this code would be a part of a bigger system where a list of available products would be maintained with their type and import status. For the purposes of this exercise I used a frozen array `PRODUCTS` in the product.rb file which is used as a reference when importing line items.

## Installation

```
gem install bundler
bundle install
```

## Testing

To run the specs:

```
bundle exec rspec
```
