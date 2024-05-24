require_relative '../lib/store.rb'

RSpec.describe Store do
  describe '#initialize' do
    it 'should initialize a new store with an empty prices hash' do
      store = Store.new

      expect(store.prices).to eq({})
    end
  end

  describe '#import_price_list' do
    it 'should parse the price list csv into the prices hash' do
      store = Store.new
      expect(store.prices).to eq({})

      store.import_price_list('prices.csv')

      expect(store.prices).to eq({ "Candy Bar" => 500,
                                   "Paperback Book" => 700,
                                   "Detergent" => 1000,
                                   "Headphones" => 1400,
                                   "Earmuffs" => 2000,
                                   "Bluetooth Stereo" => 6000})
    end
  end
end