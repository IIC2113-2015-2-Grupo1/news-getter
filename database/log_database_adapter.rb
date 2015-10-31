# encoding: UTF-8

require 'pg'
# Adapter for the log database. This database checks if the news
# has already been retrieved
class LogDatabaseAdapter
  # Saves new news to the database.
  # receives a news (string) returns a bool
  # true if successful

  attr_accessor :conn

  def initialize
    @conn = PG.connect( dbname: ENV['DBNAME'], user: ENV['DBUSER'], password: ENV['DBPASSWORD'] )
  end

  # save news to the database
  def save(news)
    fail NotImplementedError, 'subclass must implement this method'
  end

  # Checks if the news is already in the database.
  # receives a news (hash) returns a bool
  # true if is already on db
  def contains(news)
    url = news['url']
    response = @conn.exec("SELECT COUNT(url) FROM news_items WHERE url='#{url}'")
    count = response[0]
    count["count"].to_i > 0
    #fail NotImplementedError, 'subclass must implement this method'
  end
end
