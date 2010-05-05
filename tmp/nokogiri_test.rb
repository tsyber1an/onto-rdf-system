require 'rubygems'
require 'nokogirl'
require 'open-uri'
require 'cgi'
require 'pp'



$info = Array.new


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

def parse(str)
	return str.gsub(/\r|\n|\t|\f/,'').gsub(/ +/,' ').gsub(/\302\240/,'').gsub(/\|/,'')
end


def lookup(elem,href = nil)
	unless elem.children.nil?
		elem.children.each do |node|
			if node.class == Nokogiri::XML::Text
				content = parse(node.content)
				$info << {:context => href,:content => content} if content != " " and content != ""
			else 
				if node.element?
					lookup(node,href)
				end	
			end
		end
	else
		return false
	end
end



url = search_site(:google) + query("Марчук Александр Гурьевич")

doc = Nokogiri::HTML(open(url, :proxy => false))

doc.search('h3.r a.l', '//h3/a[@class="l"]').each do |link|
		inner_doc = Nokogiri::HTML(open(link['href'], :proxy => false))
		#используем children вместо простой итерации, так мы обойдем все узлы дерева
		lookup(inner_doc.xpath("//body"), link['href'])
		#define charset
		#define title
		#define description
		#title = link.content
		#charset = ""
		#description = ""
		#inner_doc.xpath('//meta[@http-equiv="Content-Type"]').each do |n| charset = n['content'] end
		#inner_doc.xpath('//meta[@name="description"]').each do |n| description = n['content'] end		
		#$info << {:context => link['href'],
		# :info => "Кодировка:" + (charset.to_s || "system default") 
		#+ " Название " + title + " Описание: " + description || "empty" }
		#?
end

File.open("parsing_out", 'w+') do |f|
	f.write("Всего источников с различным контентом: " + $info.size.to_s + "\n")
	$info.each do |elem|
		unless elem[:content].nil?
		 f.write("Источник: " + elem[:context] + "  Котент!> " + elem[:content] + "\n")	
		end
	end
end



$info = []

