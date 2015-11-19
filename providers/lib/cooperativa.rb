# encoding: UTF-8

require 'nokogiri'
require 'open-uri'

require_relative './../provider_strategy'

# Cooperativa Provider
class CooperativaProvider < ProviderStrategy
  # Inherited method
  def run(last)
    puts 'Running Cooperativa'
    page = 'http://www.cooperativa.cl/noticias/site/tax/port/all/rss____1.xml'
    doc = Nokogiri::HTML(open(page))
    doc.xpath('//item').collect do |element|
      url2 = element.xpath('link/following-sibling::text()[1]').text.strip
      return false unless @persistence_delegate.should_download?(url2)
      doc2 = Nokogiri::HTML(open(url2))
      notice = {
        title: element.xpath('title').text.strip,
        source: 5,
        subtitle: '',
        url: url2,
        tags: '',
        body: doc2.xpath("//div[contains(@class, 'CUERPO')]/p").text,
        image: "http://www.cooperativa.cl#{element.xpath('prontus_fotolibre').text.strip}"
      }
      @persistence_delegate.notify_new(notice)
    end
  end
end
