require 'net/http'
require 'rubygems'
require 'RocketAMF'
require 'rest-client'



file = File.read("amf")
env= RocketAMF::Envelope.new.populate_from_stream(file)

if ARGV.first
  file = file.force_encoding("BINARY").gsub(/08204202/,ARGV.first)
end

#env = RocketAMF::Envelope.new :amf_version => 3
#env.messages << RocketAMF::Message.new('ServiciosBean.getCiudadDestino', '/15', data)
RestClient.proxy = "http://127.0.0.1:8888"
res = RestClient.post 'http://www.ventapasajes.cl/fullpassServer/messagebroker/amf', file, :content_type => 'application/x-amf'
RocketAMF::Envelope.new.populate_from_stream(res).messages[0].data.body.each{
  |h|
  p h
}

