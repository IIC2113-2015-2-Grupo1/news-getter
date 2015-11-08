# encoding: UTF-8

require 'pg'

# Concrete implementation of the database adapters
class PostgresDatabase
  attr_accessor :conn

  def initialize
    if ENV['APP_ENV'] == 'PRODUCTION'
      @conn = PG::Connection.new(host: 'db',
                                 port: 5432,
                                 dbname: 'TuConstituyes_production',
                                 user: 'postgres')
    else
      @conn = PG::Connection.new(dbname: 'news-getter')
    end
  end

  # save news to the database
  def save(news_item)
    return false unless validate_hash(news_item)
    query = 'insert into news_items (title, body, image, url)'
    query << ' values ($1, $2, $3, $4)'
    conn.prepare('query', query)
    conn.exec_prepared(
      'query',
      [news_item['title'], news_item['body'],
       news_item['image'], news_item['url']]
    )
  end

  def log(news_item)
  end

  # Checks if the news is already in the database.
  # receives a news (hash) returns a bool
  # true if is already on db
  def contains?(news)
    url = news['url']
    response = @conn.exec('SELECT COUNT(url) FROM news_items WHERE url=$', url)
    count = response[0]
    count['count'].to_i > 0
  end

  # Check that the new's hash is valid
  private def validate_hash(news)
    %w(title url body image).all? { |s| news.key? s }
  end
end
