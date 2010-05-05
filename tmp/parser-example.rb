require 'rubygems'
require 'rdf'
require 'rdf/ntriples'
require 'rdf/raptor'

#Serializing RDF statements into an output file
data = RDF::Graph.load("foaf.nt")

RDF::Writer.open("output.rdf") do |writer|
  data.each_statement do |statement|
    writer << statement
  end
end


#Serializing RDF statements into a string result
# 1. После сбора информации "Ночной демон" будет толкать информация в ntriples  
#  1.1 Бага: факты не проходят проверки	
# 2. Обход хранения информации в БД и необходимости синхронизации
#
output = RDF::Writer.for(:ntriples).buffer do |writer|
  subject = RDF::Node.new
  writer << [subject, RDF.type, RDF::FOAF.Person]
  writer << [subject, RDF::FOAF.name, "J. Random Hacker"]
  writer << [subject, RDF::FOAF.mbox, RDF::URI("mailto:jhacker@example.org")]
  writer << [subject, RDF::FOAF.nick, "jhacker"]
end


