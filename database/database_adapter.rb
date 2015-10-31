# encoding: UTF-8

# Adapter for the database
class DatabaseAdapter
  # Saves a news to the database.
  # receives a news (string) returns a bool
  # true if successful
  def save(news)
    fail NotImplementedError, 'subclass must implement this method'
  end
end
