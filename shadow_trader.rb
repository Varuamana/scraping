require 'nokogiri'
require 'open-uri'

def get_the_currency(market_url)
	doc = Nokogiri::HTML(open(market_url))
	currency = Hash.new
	m = 1
	while m < doc.css("td.text-center").size        #valeur pour définir le nombre d'éléments dans le tableau. Ici, le nombre de cryptomonnaie (2062)
		currency[doc.xpath("/html/body/div[2]/div/div[1]/div[2]/div[3]/div[2]/table/tbody/tr[#{m}]/td[2]/a").text] = doc.xpath("/html/body/div[2]/div/div[1]/div[2]/div[3]/div[2]/table/tbody/tr[#{m}]/td[5]/a").text
        m += 1
	end
	print currency
end

get_the_currency("https://coinmarketcap.com/all/views/all/")

