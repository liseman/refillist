#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'awesome_print'

shelf_id = "100"

uri = URI("http://api.cosm.com:80/v2/feeds/116630.json?datastreams=0,1,2")
http = Net::HTTP.new(uri.host, uri.port)

headers = {
  'X-ApiKey' => '8rKRgxOtdI6IxGnocgQEiUyAUJuSAKx1T1dwL3M0cEVRVT0g'
}

path = uri.path.empty? ? "/" : uri.path

code = http.head(path, headers).code.to_i
if (code >= 200 && code < 300) then

    #the data is available...
    #http.get(uri.path, headers) do |chunk|
    #    #provided the data is good, print it...
    #    print chunk unless chunk =~ />416.+Range/
    #end
    resp = http.get2(uri.path, headers)
    #real_res = JSON.parse(resp.body)

    #ap resp.body.to_s

    uri_out = URI.parse("http://localhost:3000/push/#{shelf_id}")
    resp_out = Net::HTTP.post_form( uri_out, "json" => resp.body.to_s )
    #real_res['datastreams'].each do |data|
    #  puts "------"
    #  puts data['id']
    #  puts data['current_value']
    #  puts data['at']
    #  puts "------"
    #end
end

