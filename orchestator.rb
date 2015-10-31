# encoding: UTF-8

require 'singleton'

require_relative 'balancer'
require_relative 'loaders/local_dir_loader'
require_relative 'database/database_adapter.rb'
require_relative 'database/log_database_adapter.rb'

# Main coordinating class of the News Getter. It is
# responsible making the Balancer, Loader, LogDatabaseAdapter
# and DatabaseAdapter work together in an armonic way. It also
# handles the outputs from the different elements of this module.
class Orchestator
  include Singleton

  def initialize
    @log_db = nil
    @persistence_db = nil
    @balancer = Balancer.new
    @loader = LocalDirLoader.new
  end

  # Starts the Orchestator
  def start
    @loader.providers.each do |provider|
      puts provider
      provider.persistence_delegate = self
      @balancer.queue(provider)
    end
  end

  # It checks if a news has already been downloaded and saved
  # to the database. If it hasn't, then it procedes to save it.
  # It recieves the news URL as a parameter.
  def should_download(string)
    true
  end

  # Notifies the PersistenceDelegate's receivers when a new news
  # has been received.
  def notify_new(news_item)
  end

  # Saves a recently acquired news to the database.
  def save(news_item)
  end

  # Writes a new log entry.
  def log(news_item)
  end
end
