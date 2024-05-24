class ItemSelector
  attr_reader :prices,
              :balance,
              :items,
              :i1_index,
              :final_i1_index,
              :i2_index,
              :final_i2_index

  def initialize(prices, balance)
    @prices = prices
    @balance = balance
    @items = nil
  end

  def select_items
    return if no_possible_items?
    set_starting_indexes

    while @i1_index < @i2_index
      new_delta = @balance - item_sum(@i1_index, @i2_index)

      if new_delta <= @delta && new_delta >= 0
        @delta = new_delta
        @final_i1_index, @final_i2_index = @i1_index, @i2_index
        @i1_index += 1
        break if @delta == 0
      elsif item_sum(@i1_index, @i2_index) < @balance
        @i1_index += 1
      else
        @i2_index -= 1
      end
    end

    @items = [@prices.keys[@final_i1_index], @prices.keys[@final_i2_index]]
  end

  private

  def no_possible_items?
    smallest_sum = item_sum(0,1)
    smallest_sum > @balance
  end

  def item_sum(index_1, index_2)
    @prices.values[index_1] + @prices.values[index_2]
  end

  def set_starting_indexes
    @i1_index = 0
    @i2_index = prices.length - 1
    @final_i1_index = @i1_index
    @delta = balance - item_sum(@i1_index, @i2_index)

    until @delta >= 0
      @i2_index -= 1
      @delta = @balance - item_sum(@i1_index, @i2_index)
    end

    @final_i2_index = @i2_index
  end
end
