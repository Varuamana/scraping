require 'open-uri'
require 'nokogiri'

#initialisation des arrays
@first_name = []
@last_name = []
@url_tab = []
@mail_tab = []

#trouver les url de chaque députés
def url 
    
    Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/tableau")).css('tbody tr td a').each do |link|
        
        @url_tab << "http://www2.assemblee-nationale.fr" + link['href']
    
    end

end

#Identifier les mails des députés et les mettre dans un array
def get_the_email_of_a_deputy_from_its_webpage(url)
    
    @url_tab.each do |url|
        
        Nokogiri::HTML(open(url)).css('dd:nth-child(3) > a.email').each do |mail|

            @mail_tab << mail['href'].delete_prefix('mailto:')

        end
    
    end

end

#Prénom et noms
def get_the_assembly(assembly)


    doc = Nokogiri::HTML(open(assembly)).css("tbody tr td a").each do |link|
    
        @first_name << link.text.split[1]
    
        @last_name << link.text.split[2]

    end

end

#Un array pour les rassembler tous !
def create_hash
    
    array = []
    
    @url_tab.each.with_index do |x, i|
        
        x = Hash.new

        x["Nom"] = @last_name[i]
        x["Prénom"] = @first_name[i]
        x["Mail"] = @mail_tab[i]
        
        array << x 
    
    end
    
    puts array

end

url
get_the_email_of_a_deputy_from_its_webpage("http://www2.assemblee-nationale.fr/deputes/fiche/OMC_PA605036")
get_the_assembly("http://www2.assemblee-nationale.fr/deputes/liste/tableau")
create_hash