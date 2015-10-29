# encoding: UTF-8

require_relative './../provider_strategy'

# CNN Provider
class CNNProvider < ProviderStrategy
  def run(last)
    # TODO: complete
    @persistence_delegate.notify_new(nil)
  end
end
