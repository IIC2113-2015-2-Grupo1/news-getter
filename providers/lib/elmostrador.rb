require 'nokogiri'
require 'open-uri'

require_relative './../provider_strategy'

#El Mostrador Provider
class ElMostradorProvider < ProviderStrategy

	#Inherited method
	def run(last)
		doc = Nokogiri::HTML(open('http://www.elmostrador.cl/destacado/feed/'))
		doc.xpath('//item').collect do |element|
			url = element.xpath('link')
			return unless @persistence_delegate.should_download?(url)
			title = element.xpath('title')
			image = element.xpath('image')
			content = element.xpath('content')
			subtitle = element.xpath('description')
			notice = {title: '#{title}', subtitle: '#{subtitle}', url: '#{url}', tags: '', body: '#{body}', image: '#{image}' }
      		@persistence_delegate.notify_new(notice)
		end
	end 	 	
  end
end