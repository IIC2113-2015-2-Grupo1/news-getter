# encoding: UTF-8

require_relative './../provider_strategy'

# CNN Provider
class CNNProvider < ProviderStrategy
  def run(last)
    return unless @persistence_delegate.should_download?('id')

    # TODO: complete

    @persistence_delegate.notify_new(newsitem)
  end
end
