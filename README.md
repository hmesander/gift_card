# Gift Card

Gift Card is a Ruby command-line tool to retrieve two items from a list of 
store prices that are equal to or as close as possible to a gift card balance.

## Usage
```bash
# from the root project directory

ruby lib/find_pair.rb prices.csv 2500
# returns "Candy Bar 500, Earmuffs 2000" - exact amount of gift card

ruby lib/find_pair.rb prices.csv 2300
# returns "Paperback Book 700, Headphones 1400" - closest amount less than gift card

ruby lib/find_pair.rb prices.csv 1100
# returns "Not possible" - gift card balance is not large enough to buy two items
```

## Running Specs
```bash
# from the root project directory

# run entire spec suite
rspec

# run a single spec
rspec spec/item_selector_spec.rb
```

## Algorithm Notes
Because the given price list is sorted, the algorithm seeks to sum the first and last 
items in the list and then move toward the center of the list depending on how the sum 
compares to the gift card balance.  

Additionally, the algorithm keeps track of the closest pair sum to the gift card balance
in order return the pair of items that is both less than and closest to the gift card balance.

This allows the problem to be solved with only a single iteration through the price data, 
as opposed to a nested-loop algorithm to obtain all pair sums, which would be less efficient.