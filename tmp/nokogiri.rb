require 'rubygems'
require 'nokogirl'
require 'open-uri'
require 'cgi'


def search_site(name)
	case name
		when :google then return "http://www.google.com/search?q="	
	else
		return "http://www.google.com/search?q="	
	end
end

def query(str)
	return CGI.escape(str)
end

def lookuptree(elem)
	if elem.nil? && !elem.cdata?
		elem.children.each do |node|
			if node === Nokogiri::XML::Text
				#make parse
				puts node.content + node.object_id.to_s
			else 
				#if node is Nokogiri::XML::Element
				if node.element?
					#call recursive function	
						lookuptree(node)
				end	
			end
		end
	else
		return false
	end
end




url = search_site(:google) + query("Марчук Александр Гурьевич")

doc = Nokogiri::HTML(open(url, :proxy => false))


#search_stories = Array.new
####
# Or mix and match.
doc.search('h3.r a.l', '//h3/a[@class="l"]').each do |link|
  #search_stories << {:resource => link['href'],:name => link.content}

	#search_stories.each do |story|
	#system output check
	#puts "Источник " + story[:resource] + ". Название " + story[:name] + "\n"
		inner_doc = Nokogiri::HTML(open(link['href'], :proxy => false))
	#	doc.search('//meta[@http-equiv="Content-Type"]').each do |tag|
			#define charset of document
			#to-do 
			#	1.need to parse this one corrently, now you have something "text/html; chartset=windows-1251"
			# 	Need to get from this substring with pattern charset=$
			#   Idea: use string matching patterns

			#uncoment after finish all process
	#		puts tag['content']
	#	end

		inner_doc.search("//body").search do |node|	
			#if link.content have substring line директор Директор ДИРЕКТОР then взять соседа от него до запятой 			# или точки and then escape those words
			puts "nil" if node.eql? nil
			lookuptree(node)
		end

	#end

end

#база должностей
base = Hash.new
base[:position ] = Array.new

base[:position ] << ["директор", "д.ф.-м.н.", "заведующий", "председатель", "член", "сотрудник", "старший научный сотрудник", "доцент", "программист"]




