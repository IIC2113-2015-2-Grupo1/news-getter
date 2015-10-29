# encoding: UTF-8

# Base class for all strategies.
class ProviderStrategy
  attr_accessor :persistence_delegate

  def initialize(persistence_delegate = nil)
    @persistence_delegate = persistence_delegate
  end

  # Recieves the last news (string) fetch from the source
  # and returns a list of new news (list<string>)
  def run(last)
    # fail NotImplementedError, 'subclass must implement this method'
  end
end
