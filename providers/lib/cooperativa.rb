require 'nokogiri'
require 'open-uri'

require_relative './../provider_strategy'

# Cooperativa Provider
class CooperativaProvider < ProviderStrategy
  # Inherited method
  def run(last)
    doc = Nokogiri::HTML(open('http://www.cooperativa.cl/noticias/site/tax/port/all/rss____1.xml'))
    doc.xpath('//item').collect do |element|
      url = element.xpath('link/following-sibling::text()[1]').text.strip
      return unless @persistence_delegate.should_download?(url)
      title = element.xpath('title').text.strip
      image = 'http://www.cooperativa.cl' + element.xpath('prontus_fotolibre').text.strip
      subtitle = ''
      doc2 = Nokogiri::HTML(open(url.to_s))
      source = doc2.xpath('//header/div/span/strong').text.strip
      content = doc2.xpath("//div[contains(@class, 'CUERPO')]/p").text
      notice = {title: "#{title}", source: "#{source}", subtitle: "#{subtitle}", url: "#{url}", tags: "", body: "#{content}", image: "#{image}" }
      @persistence_delegate.notify_new(notice)
    end
  end
end
