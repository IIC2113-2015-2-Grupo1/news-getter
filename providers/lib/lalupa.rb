# encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require_relative './../provider_strategy'

# La Lupa de la Constitucion Provider
class LaLupa < ProviderStrategy
  # Inherited method
  def run(last)
    puts 'Running LaLupa'
    url = 'http://www.lalupadelaconstitucion.cl/noticias/'
    doc = Nokogiri::HTML(open(url))
    doc.xpath('//div[contains(@class, "news-box") and not(contains(@class, "constitucion-box"))]//a[not(@href = preceding::*/@href)]/@href').collect do |element|
      return false unless @persistence_delegate.should_download?(element.to_s)
      doc2 = Nokogiri::HTML(open(element.to_s))
      notice = {
        title: doc2.xpath('//h2[@class="single-article-title"]').text.strip,
        source: 3,
        subtitle: doc2.xpath('//h3[@class="single-article-subtitle"]').text.strip,
        url: element.to_s,
        tags: '',
        body: doc2.xpath('//div[@class="single-article-text"]').text.strip.gsub("\n", ""),
        image: doc2.xpath('//div[@class="single-article-main-image"]/img/@src').text.strip
      }
      @persistence_delegate.notify_new(notice)
    end
  end
end
