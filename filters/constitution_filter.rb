# ConstitutionFilter file
require 'json'

# yet antoher simple filter class
class ConstitutionFilter
  # words to look in the news
  attr_accessor :key_words

  # initialize
  def initialize
    key_words = File.read('./filters/key_words.json')
    @key_words = JSON.parse(key_words)['words']
  end

  # filter news
  def filter_news(news)
    @key_words.each do |word|
      return news if news[:body].include? word
    end
    false
  end
end
