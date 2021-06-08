# frozen_string_literal: true

require 'taxes/rounder'

RSpec.describe Rounder do
  describe '#round_up to 5 cents' do
    before(:context) do
      @rounder = Rounder.new(5)
    end

    it 'rounds to 55 cents whent given 54.9' do
      expect(@rounder.round_up(54.9)).to eq 55
    end

    it 'rounds to 55 cents whent given 54.1' do
      expect(@rounder.round_up(54.1)).to eq 55
    end

    it 'rounds to 55 cents whent given 50.1' do
      expect(@rounder.round_up(50.1)).to eq 55
    end

    it 'rounds to 55 cents whent given 52.5' do
      expect(@rounder.round_up(52.5)).to eq 55
    end

    it 'rounds to 60 cents whent given 55.1' do
      expect(@rounder.round_up(55.1)).to eq 60
    end
  end
end
