require 'rubygems'
require 'rdf'
require 'rdf/ntriples'
require 'rdf/raptor'
require 'sparql/client'
require 'cgi'

url = CGI.escape("http://tema.livejournal.com/data/foaf.rdf")

sparql = SPARQL::Client.new("http://dbpedia.org/sparql?default-graph-uri=" + url)

foaf =  RDF::Vocabulary.new("http://xmlns.com/foaf/0.1/")


query = sparql.select.where([:s, foaf[:name], :o]).offset(100).limit(10)

query.each_solution do |solution|
  puts solution.inspect
end


