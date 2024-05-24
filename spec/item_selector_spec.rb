require_relative '../lib/item_selector'

RSpec.describe ItemSelector do
  let(:prices) {
    { "Candy Bar" => 500,
      "Paperback Book" => 700,
      "Detergent" => 1000,
      "Headphones" => 1400,
      "Earmuffs" => 2000,
      "Bluetooth Stereo" => 6000}
  }

  describe '#initialize' do
    it 'initializes an item selector with prices, balance and no selected items' do
      item_selector = ItemSelector.new(prices, 1500)

      expect(item_selector.prices).to eq(prices)
      expect(item_selector.balance).to eq(1500)
      expect(item_selector.items).to be_nil
    end
  end
end