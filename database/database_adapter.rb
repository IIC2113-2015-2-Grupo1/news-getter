# encoding: UTF-8

require 'pg'
# Adapter for the database
class DatabaseAdapter
  # Saves a news to the database.
  # receives a news (string) returns a bool
  # true if successful
  attr_reader :conn

  def initialize
    @conn = PG.connect( dbname: ENV['DBNAME'], user: ENV['DBUSER'], password: ENV['DBPASSWORD'] )
  end

  # news should be a Hash
  def save(news)
    if validate_hash news
      query = 'insert into news_items (title, body, image, url) values ($1, $2, $3, $4)'
      conn.prepare('query', query)
      conn.exec_prepared('query', [news['title'], news['body'], news['image'], news['url'] ])
      return true
    else
      return false
    end
    #fail NotImplementedError, 'subclass must implement this method'
  end

  # check that the hash is valid
  def validate_hash(news)
    begin
      response = ['title', 'body', 'image', 'url'].all? {|s| news.key? s}
    rescue
      return false
    end
    response
  end
end
