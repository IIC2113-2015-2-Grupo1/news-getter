require 'nokogiri'
require_relative './../provider_strategy'

# Provider del diario LaTercera
class LaTerceraProvider < ProviderStrategy
  def run(last)
    newsdoc = Nokogiri::HTML(open('http://www.latercera.com/feed/manager?type=rss&sc=TEFURVJDRVJB'))

    # Getting news
    news = newsdoc.xpath('//item').collect do |node|
      title = node.xpath('title/text()')
      subtitle = node.xpath('description/text()').text
      url = node.xpath('guid/text()')

      return unless @persistence_delegate.should_download?(url)

      noticedoc = Nokogiri::HTML(open(url.to_s))
      body = fetch_body noticedoc
      image = fetch_image noticedoc
      tags = fetch_tags noticedoc

      notice = {title: "#{title}",
      subtitle: "#{subtitle}",
      url: "#{url}",
      tags: "#{tags}",
      body: "#{body}",
      image: "#{image}" }
      @persistence_delegate.notify_new(notice)
    end
    news
  end

  # Obtain body in the url
  def fetch_body(body)
    aux = ''
    # Lo normal es que este el body en ese contenedor.
    body.xpath("//div[contains(@class, 'article-center-text')]/p/text()").each do |line|
      aux = aux + line.text + "\n"
    end
    aux
  end

  # Obtain image in the url
  def fetch_image(image)
    aux = image.xpath("//div[contains(@class, 'wrapfoto')]/img/@src")
    aux
  end

  # Obtain tags in the url
  def fetch_tags(tags)
    aux = ''
    tags.xpath("//ul[contains(@class, 'listags')]/li/a/text()").each do |tag|
      aux << tag.text
    end
    aux
  end
end
