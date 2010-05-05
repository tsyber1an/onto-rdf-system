require 'rubygems'
require 'sanitize'
require 'hpricot'
require 'open-uri'


namespace :utils do 
	desc "Migrate users from web resource"

	task(:datafill2 => :environment) do
		rooturl = "http://globalmmf.ru"
		firsturl = "http://globalmmf.ru/node/14"
		doc = open(firsturl) { |f| Hpricot(f)}
		groupids = []
		groupcounts = []
		doc.search("div[@id='node-14']").search("ul/li").each do |li|

			#test print
			#pp clean(li.at('a').to_html)
			suburl = li.at('a')['href']
			year = li.at('a').inner_html


			#get node id
			nodeid = suburl.gsub(/[a-z]/,"").scan(/\d+/).to_s

			node = open(rooturl + suburl ){ |f| Hpricot(f) }
			node_data = node.search("div[@id='node-#{@nodeid}'")
			
			node_data.search("h2").each do |gr|
				groupids << gr.inner_html.to_s.gsub(/\s/,"").scan(/\d+/).to_s
			end			
			
			nodedata = node_data.search("ol")
			
			nodedata.each_with_index do |iperson,gid|
				persons = iperson.search("li")
				groupcounts << persons.size
				persons.each do |person|
					fullname = person.inner_html.scan(/\w+/)
					student = Mexmat.new
					student.year = year
					student.firstname = fullname[1]
					student.lastname = fullname[0]
					student.middlename = fullname[2]
					student.group = groupids[gid]
					student.save
				end	
				puts "Group " + groupids[gid].to_s + " saved"
			end

			groupids = []
			groupcounts = []

			#if timeouts
			#go rescue and reconnect
		end

	end
end

