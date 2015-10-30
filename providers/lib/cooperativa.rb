require "nokogiri"
require "open-uri"

require_relative "./../provider_strategy"

#El Mostrador Provider
class CooperativaProvider
	#Inherited method
	def run(last)
		doc = Nokogiri::HTML(open("http://www.cooperativa.cl/noticias/site/tax/port/all/rss____1.xml"))
		doc.xpath("//item").collect do |element|
			url = element.xpath("link")
			#return unless @persistence_delegate.should_download?(url)
			title = element.xpath("title")
			image = element.xpath("image")
			subtitle = ""
			doc2 = Nokogiri::HTML(open(url.to_s))
			source = doc2.xpath("//header/div/span/strong").text
			content = doc2.xpath('//div/p[contains(@class, "CUERPO")]').text
			notice = {title: "#{title}", source: "#{source}", subtitle: "#{subtitle}", url: "#{url}", tags: "", body: "#{content}", image: "#{image}" }
	   		puts notice
	   		#@persistence_delegate.notify_new(notice)
	end 	 	
  end
end

c = CooperativaProvider.new
c.run(nil)