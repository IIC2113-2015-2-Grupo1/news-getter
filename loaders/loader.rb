# encoding: UTF-8

# Loads the strategy patterns that fetch fresh news.
class Loader
  # loads a strategy
  # receives nothing returns a ProviderStrategy
  def providers
    fail NotImplementedError, 'subclass must implement this method'
  end
end
