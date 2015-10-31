# encoding: UTF-8

# Adapter for the log database. This database checks if the news
# has already been retrieved
class LogDatabseAdapter
  # Saves new news to the database.
  # receives a news (string) returns a bool
  # true if successful
  def save(news)
    fail NotImplementedError, 'subclass must implement this method'
  end

  # Checks if the news is already in the database.
  # receives a news (string) returns a bool
  # true if is already on db
  def contains(news)
    fail NotImplementedError, 'subclass must implement this method'
  end
end
