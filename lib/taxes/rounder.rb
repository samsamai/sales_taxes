# frozen_string_literal: true

# Rounder class allows rounding up to the nearst integer
class Rounder
  def initialize(round_up_to_n)
    raise BadRoundUpIncrement if round_up_to_n <= 0

    @round_up_to_n = round_up_to_n
  end

  def round_up(amount)
    return 0 if amount <= 0 || @round_up_to_n.zero?

    (amount / @round_up_to_n.to_f).ceil * @round_up_to_n
  end
end
