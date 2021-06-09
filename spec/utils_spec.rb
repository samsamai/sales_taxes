# frozen_string_literal: true

require 'utils'

RSpec.describe 'utils' do
  describe 'currency_format' do
    it 'returns value 0 padded to 2 dec pts as a string' do
      expect(currency_format(20.2)).to eq '20.20'
      expect(currency_format(20.20233232)).to eq '20.20'
      expect(currency_format(10)).to eq '10.00'
    end
  end
end
