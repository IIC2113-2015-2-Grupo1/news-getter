# encoding: UTF-8

require_relative './../../providers/provider_strategy'

# Dummy Provider
class DummyProvider < ProviderStrategy
  def run(last)
    return unless @persistence_delegate.should_download?('id')

    # TODO: complete

    @persistence_delegate.notify_new(newsitem)
  end
end
