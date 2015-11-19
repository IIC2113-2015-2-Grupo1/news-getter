# encoding: UTF-8

require 'pg'

require_relative './../filters/region_filter'
require_relative './../filters/constitution_filter'

# Concrete implementation of the database adapters
class PostgresDatabase
  attr_accessor :region_filter
  attr_accessor :process_filter

  def initialize
    @region_filter = RegionFilter.new
    @process_filter = ConstitutionFilter.new
  end

  # save news to the database
  def save(news_item)
    return false unless validate_hash(news_item)
    clean_news(news_item)
    @region_filter.region_filter(news_item)
    conn = new_conn
    conn.exec(prepare_query(news_item))
  end

  def log(news_item)
  end

  # Checks if the news is already in the database.
  # receives a news (hash) returns a bool
  # true if is already on db
  def contains?(url)
    conn = new_conn
    response = conn.exec("SELECT COUNT(url) FROM news_items WHERE url='#{url}'")
    count = response[0]
    count['count'].to_i > 0
  end

  # Check that the new's hash is valid
  private def validate_hash(news)
    return false if news.nil?
    [:title, :body, :image, :url].all? { |s| news.key? s }
  end
  def prepare_query(news_item)
    query = "insert into news_items (title, body, image, url, source_id,
             region_id, created_at, updated_at) values
             ('#{news_item[:title]}' , '#{news_item[:body]}' ,
              '#{news_item[:image]}', '#{news_item[:url]}',
               #{news_item[:source]}, #{news_item[:region]},
               '#{Time.now}', '#{Time.now}')"
    query
  end

  def clean_news(news_item)
    news_item[:title].gsub(/[^0-9A-Za-z  .]/, '')
    news_item[:body].gsub(/[^0-9A-Za-z  .]/, '')
  end

  def new_conn
    if ENV['APP_ENV'] == 'PRODUCTION'
      return PG::Connection.new(host: 'db',
                                port: 5432,
                                dbname: 'TuConstituyes_production',
                                user: 'postgres')
    else
      return PG::Connection.new(dbname: 'TuConstituyes_development')
    end
  end
end
