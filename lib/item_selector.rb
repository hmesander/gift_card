class ItemSelector
  attr_reader :prices, :balance, :items

  def initialize(prices, balance)
    @prices = prices
    @balance = balance
    @items = nil
  end

  def select_items
    smallest_sum = @prices.values[0] + @prices.values[1]
    return if smallest_sum > @balance

    i1_index = 0
    i2_index = prices.length - 1
    final_i1_index = i1_index
    delta = balance - (@prices.values[i1_index] + @prices.values[i2_index])

    until delta >= 0
      i2_index -= 1
      delta = @balance - (@prices.values[i1_index] + @prices.values[i2_index])
    end

    final_i2_index = i2_index

    while i1_index < i2_index
      new_delta = @balance - (@prices.values[i1_index] + @prices.values[i2_index])

      if new_delta <= delta && new_delta >= 0
        delta = new_delta
        final_i1_index, final_i2_index = i1_index, i2_index
        i1_index += 1
        break if delta == 0
      elsif @prices.values[i1_index] + @prices.values[i2_index] < @balance
        i1_index += 1
      else
        i2_index -= 1
      end
    end

    @items = [@prices.keys[final_i1_index], @prices.keys[final_i2_index]]
  end
end
