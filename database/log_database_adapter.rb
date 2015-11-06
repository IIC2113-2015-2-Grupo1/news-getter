# encoding: UTF-8

# Adapter for the log database. This database checks if the news
# has already been retrieved
class LogDatabaseAdapter
  # Saves a new news_item to the log database.
  # returns a true on sucess
  def log(news_item)
    fail NotImplementedError, 'subclass must implement this method'
  end

  # Checks if the news is already in the database.
  # receives a news (hash) returns a bool
  # true if is already on db
  def contains?(news_item)
    fail NotImplementedError, 'subclass must implement this method'
  end
end
