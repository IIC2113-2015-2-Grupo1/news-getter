# encoding: UTF-8

# Base class for all strategies.
class ProviderStrategy
  # Recieves the last news (string) fetch from the source
  # and returns a list of new news (list<string>)
  def run(last)
    fail NotImplementedError, 'subclass must implement this method'
  end
end
