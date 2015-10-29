# Manage the database actions
class PersistenceDelegate
  def should_download?(identifier)
    fail NotImplementedError, 'subclass must implement this method'
  end

  def notify_new(news_item)
    fail NotImplementedError, 'subclass must implement this method'
  end
end
