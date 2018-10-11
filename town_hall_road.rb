require 'open-uri'
require 'nokogiri'

def get_the_email_of_a_townhal_from_its_webpage(townmail)
        
    doc = Nokogiri::HTML(open(townmail))
    doc1 = doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]')    
    return doc1.text #enlève les balise </tr>
end

def get_all_the_urls_of_val_doise_townhalls(townurl)

    doc2 = Nokogiri::HTML(open(townurl))
    
    c = 1 ; u = 1                                   #c pour colonne et u pour url
	url = Hash.new
	while c < 4                                     #nombre de colonnes sur le site
		while (u < 63 && c < 3) || u < 62           #nombre d'url (ou nom). On le trouve en prenant le xpath du dernier élément de la colonne et on trouve 62.
			doc3 = doc2.xpath("/html/body/table/tr[3]/td/table/tr/td[2]/table/tr[2]/td/table/tr/td[#{c}]/p/a[#{u}]/@href")       #chemin vers la colonne et l'url demandé (c et u)
			url[doc3.to_s.split('/').last.split('.').first.capitalize] = get_the_email_of_a_townhal_from_its_webpage(doc3.to_s.sub(".", "http://annuaire-des-mairies.com"))      #permet de remplacer le ./ de début d'url par l'url originel http://annuaire.. 
			u += 1
		end
		u = 1
		c += 1
	end

    puts url

end

get_all_the_urls_of_val_doise_townhalls('http://annuaire-des-mairies.com/val-d-oise.html')

#/html/body/table/tbody/tr[3]/td/table/tbody/tr/td[2]/p[2]/object/table/tbody/tr[2]/td/table/tbody/tr/td[1]/p/a[1]
