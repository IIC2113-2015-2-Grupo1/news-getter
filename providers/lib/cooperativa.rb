# encoding: UTF-8

require 'nokogiri'
require 'open-uri'

require_relative './../provider_strategy'

# Cooperativa Provider
class CooperativaProvider < ProviderStrategy
  URL = 'http://www.cooperativa.cl/noticias/site/tax/port/all/rss____1.xml'

  # Inherited method
  def run(last)
    doc = Nokogiri::HTML(open(URL))
    doc.xpath('//item').collect do |element|
      url = element.xpath('link/following-sibling::text()[1]').text.strip
      next unless @persistence_delegate.should_download?(url)

      doc2 = Nokogiri::HTML(open(url.to_s))
      notice = {
        title: element.xpath('title').text.strip,
        source: doc2.xpath('//header/div/span/strong').text.strip,
        subtitle: '',
        url: url,
        tags: '',
        body: doc2.xpath("//div[contains(@class, 'CUERPO')]/p").text,
        image: "http://www.cooperativa.cl#{element.xpath('prontus_fotolibre').text.strip}"
      }
      puts notice
      @persistence_delegate.notify_new(notice)
    end
  end
end
