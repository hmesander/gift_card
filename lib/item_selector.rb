class ItemSelector
  attr_reader :prices, :balance, :items

  def initialize(prices, balance)
    @prices = prices
    @balance = balance
    @items = nil
  end
end
