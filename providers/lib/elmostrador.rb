require "nokogiri"
require "open-uri"

require_relative "./../provider_strategy"

#El Mostrador Provider
class ElMostradorProvider < ProviderStrategy
	#Inherited method
	def run(last)
		doc = Nokogiri::HTML(open("http://www.elmostrador.cl/destacado/feed/"))
		doc.xpath("//item").collect do |element|
			url = element.xpath("link/following-sibling::text()[1]")
			return unless @persistence_delegate.should_download?(url)
			title = element.xpath("title")
			image = element.xpath("image")
			subtitle = ""
			doc2 = Nokogiri::HTML(open(url.to_s))
			source = doc2.xpath('//p[contains(@class, "autor-y-fecha")]/span/a').text
			content = doc2.xpath('//div[contains(@class, "cuerpo-noticia")]').text
			notice = {title: "#{title}", source: "#{source}", subtitle: "#{subtitle}", url: "#{url}", tags: "", body: "#{content}", image: "#{image}" }
	   		@persistence_delegate.notify_new(notice)
		end
	end 	 	
end