require_relative 'store.rb'
require_relative 'item_selector.rb'

csv_file_path = ARGV[0]
balance = ARGV[1].to_i

store = Store.new
store.import_price_list(csv_file_path)
prices = store.prices

item_selector = ItemSelector.new(prices, balance)
item_selector.select_items

puts item_selector.readable_result