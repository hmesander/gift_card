require 'csv'

class Store
  attr_reader :prices

  def initialize
    @prices = Hash.new
  end

  def import_price_list(csv_file_path)
    CSV.foreach(csv_file_path) do |row|
      @prices[row[0]] = row[1].to_i
    end
  end
end