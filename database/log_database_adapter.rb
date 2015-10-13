# adapter fot the log database. This database checks if the news
# has already been retrieved

require "sqlite3"

class LogDatabseAdapter

  # Saves new news to the database. Returns a bool
  def save(news)
  end

  # Checks if the news is already in the database. Return a bool
  def contains
  end

end
