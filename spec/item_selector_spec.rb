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

  describe '#set_starting_indexes' do
    it "should set i1_index and final_i1_index to the cheapest item's index" do
      item_selector = ItemSelector.new(prices, 2300)
      item_selector.send(:set_starting_indexes)
      expect(item_selector.i1_index).to eq(0)
      expect(item_selector.final_i1_index).to eq(0)
    end

    it "should set i2_index and final_i2_index to the most expensive possible item's index" do
      item_selector = ItemSelector.new(prices, 2300)
      item_selector.send(:set_starting_indexes)
      expect(item_selector.i2_index).to eq(3)
      expect(item_selector.final_i2_index).to eq(3)
    end
  end

  describe '#find_indexes_of_optimal_pair' do
    it 'should set final_i1_index and final_i2_index for the correct two items' do
      item_selector = ItemSelector.new(prices, 3000)
      item_selector.send(:set_starting_indexes)

      expect(item_selector.final_i1_index).to eq(0)
      expect(item_selector.final_i2_index).to eq(4)

      item_selector.send(:find_indexes_of_optimal_pair)

      expect(item_selector.final_i1_index).to eq(2)
      expect(item_selector.final_i2_index).to eq(4)
    end
  end

  describe '#readable_result' do
    context 'when no items are selected' do
      it "should return 'Not possible'" do
        item_selector = ItemSelector.new(prices, 1100)
        item_selector.select_items
        expect(item_selector.readable_result).to eq('Not possible')
      end
    end

    context 'when items are selected' do
      it 'should return formatted string output of selected items and prices' do
        item_selector = ItemSelector.new(prices, 1500)
        item_selector.select_items
        expect(item_selector.readable_result).to eq('Candy Bar 500, Detergent 1000')
      end
    end
  end
end