# encoding: UTF-8

# Adapter for the database
class DatabaseAdapter
  # Saves a news_item to the database.
  # returns a true on sucess
  def save(news_item)
    fail NotImplementedError, 'subclass must implement this method'
  end
end
