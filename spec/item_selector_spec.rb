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

  describe '#select_items' do
    context 'when no 2 items are less than the gift card balance' do
      it 'should not select any items' do
        item_selector = ItemSelector.new(prices, 1100)
        item_selector.select_items
        expect(item_selector.items).to be_nil
      end
    end

    context 'when 2 items exactly sum to the gift card balance' do
      it 'should select the optimal 2 items' do
        item_selector = ItemSelector.new(prices, 2500)
        item_selector.select_items
        expect(item_selector.items).to match(["Candy Bar", "Earmuffs"])
      end
    end

    context 'when 2 items do not exactly sum to the gift card balance' do
      it 'should select the optimal 2 items closest to the gift card balance' do
        item_selector = ItemSelector.new(prices, 2300)
        item_selector.select_items
        expect(item_selector.items).to match(["Paperback Book", "Headphones"])
      end
    end
  end

  describe '#no_possible_items?' do
    context 'when the two cheapest items are more than the gift card balance' do
      it 'should return true' do
        item_selector = ItemSelector.new(prices, 1100)
        expect(item_selector.send(:no_possible_items?)).to eq(true)
      end
    end

    context 'when the two cheapest items are less than the gift card balance' do
      it 'should return false' do
        item_selector = ItemSelector.new(prices, 2000)
        expect(item_selector.send(:no_possible_items?)).to eq(false)
      end
    end
  end

  describe '#item_sum' do
    it "should sum items' prices given their indexes" do
      item_selector = ItemSelector.new(prices, 2300)
      expect(item_selector.send(:item_sum, 1, 2)).to eq(1700)
    end
  end
end