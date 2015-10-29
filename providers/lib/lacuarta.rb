require 'nokogiri'
require 'open-uri'

# Provider del diario LaCuarta
class LaCuartaProvider
  def fetch_news
    newsdoc = Nokogiri::HTML(open('http://www.lacuarta.com/feed/manager?type=rss&sc=TEFDVUFSVEE='))

    # Getting news
    news = newsdoc.xpath('//item').collect do |node|
      title = node.xpath('title/text()')
      subtitle = node.xpath('description/text()').text
      url = node.xpath('guid/text()')
      # No he encontrado los tags.
      tags = ''

      noticedoc = Nokogiri::HTML(open(url.to_s))
      body = fetch_body noticedoc
      image = fetch_image noticedoc

      # Aqui iria la union de todas las cosas, aun no se que poner
    end
    news
  end

  # Obtain body in the url
  def fetch_body(body)
    aux = ''
    # Lo normal es que este el body en ese contenedor.
    body.xpath("//div[contains(@class, 'l4ta_contenedorTxtARtc')]/p/text()").each do |line|
      aux = aux + line.text + "\n"
    end
    aux
  end

  # Obtain image in the url
  def fetch_image(image)
    aux = image.xpath("//div[contains(@class, 'L4ta_img_efecto')]/img/@src")
    aux
  end
end
