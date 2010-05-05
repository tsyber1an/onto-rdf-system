require 'rubygems'
require 'sanitize'
require 'hpricot'
require 'open-uri'

namespace :utils do 
	desc "Migrate users from web resource"

	task(:datafill => :environment) do

		begin 
			url = "http://mmfd.nsu.ru/Scripts/dbvip/qf1.idc"
			doc = open(url,:proxy => false) { |f| Hpricot(f) }
			wwf = false
			@table_inner = doc.search("table")

			@table_inner.search("tr").each_with_index do |tr,index|
				if index != 0
					@mmf = Mmfd.new

					(tr/"td").each_with_index do |td,i|
						case i
							when 0 then  @mmf.year = clean(td.search("font").to_html)
							when 1 then  @mmf.group = clean(td.search("font").to_html)
							when 2 then  @mmf.lastname = clean(td.search("font").to_html)
							when 3 then  @mmf.firstname = clean(td.search("font").to_html)
							when 4 then  @mmf.middlename = clean(td.search("font").to_html)
							when 5 then  @mmf.phone = clean(td.search("font").to_html)
							when 6 then  @mmf.email = clean(td.search("a").to_html)
							when 7 then  @mmf.url = clean(td.search("a").to_html)
						end																								
					end
	
				wwf = true if @mmf.save
				end
			end			
			puts "All successfully finished" if wwf == true 

		rescue StandardError => e
			puts e.to_s + "\n You have trouble! Don't give up!"
		end
	end

	
end

def clean(str)
	#
  # bugs: 
  #  - Charset
  #  - phone number parsing
	#
	###
	
	#clean_str = Iconv.conv("Windows-1251", "UTF-8",Sanitize.clean(str).gsub(/&#13;/,"").gsub(/\n/,"").rstrip.to_s)
  clean_str = Sanitize.clean(str).gsub(/&#13;/,"").gsub(/\n/,"").rstrip
  
	if clean_str == ""
		return nil
	else
		clean_str	
	end
end
