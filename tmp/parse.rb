require 'rubygems'
require 'rdf'
require 'rdf/ntriples' # Support for N-Triples (.nt)
require 'rdf/raptor'   # Support for RDF/XML (.rdf) and Turtle (.ttl)
#require 'rdf/json'     # Support for RDF/JSON (.json)
#require 'rdf/trix'     # Support for TriX (.xml)


#puts "Iterating over known RDF serialization formats \n"
#RDF::Format.each { |klass| puts klass.name }

def parse_rdf(url)
	RDF::Reader.open(url) do |reader|
		reader.each_statement do |statement|
		  puts statement.inspect
		end
	end
end

begin 
	parse_rdf("tema.rdf")
rescue Errno::ETIMEDOUT => e
	puts "Sorry, we have time out to parse: \n " + e.to_s 
rescue Exception => e
	puts e.to_s + "\nSomething happen!"	
end


