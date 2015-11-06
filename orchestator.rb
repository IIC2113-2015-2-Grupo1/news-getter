# encoding: UTF-8

require 'singleton'

require_relative 'balancer'
require_relative 'loaders/local_dir_loader'
require_relative 'database/database_adapter'
require_relative 'database/log_database_adapter'
require_relative 'database/postgres_database'

# Main coordinating class of the News Getter. It is
# responsible making the Balancer, Loader, LogDatabaseAdapter
# and DatabaseAdapter work together in an armonic way. It also
# handles the outputs from the different elements of this module.
class Orchestator
  include Singleton

  def initialize
    @persistence_db = @log_db = PostgresDatabase.new
    @balancer = Balancer.new
    @loader = LocalDirLoader.new
  end

  # Starts the Orchestator
  def start
    @loader.providers.each do |provider|
      provider.persistence_delegate = self
      @balancer.queue(provider)
    end
  end

  # It checks if a news has already been downloaded and saved
  # to the database.
  def should_download?(string)
    @log_db.contains?(string)
  end

  # Notifies the PersistenceDelegate's receivers when a new news
  # has been received.
  def notify_new(news_item)
    save(news_item)
    log(news_item)
  end

  # Saves a recently acquired news to the database.
  def save(news_item)
    @persistence_db.save(news_item)
  end

  # Writes a new log entry.
  def log(news_item)
    @log_db.log(news_item)
  end
end
