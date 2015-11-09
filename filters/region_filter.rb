# RegionFilter news
require 'json'

# Simple class to find region of the news
class RegionFilter

  attr_accessor :regions
  def initialize
    file = File.read('./filters/regions.json')
    @regions = JSON.parse(file)['regions']
  end

# filter for news
  def region_filter news
    @regions.each do |region|
      region.each do |key, value|
        if news[:body].include? key
          news[:region] = value
          return news
        end
      end
    end
    news
  end

end
