#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'awesome_print'

shelf_id = "1"

#uri = URI("https://agent.electricimp.com:443/WENqSu+U3q0X")
tot = 0
(0..9).each do
  out = `curl -s https://agent.electricimp.com/5ip8Tl09cliT`.to_i
  tot+=out
  sleep 1
end
tot/=10
puts tot

uri_out = URI.parse("http://refillist.illuminatus.org:3000/push/weight/#{shelf_id}")
resp_out = Net::HTTP.post_form( uri_out, "json" => uri_out.to_s )
#real_res['datastreams'].each do |data|
#  puts "------"
#  puts data['id']
#  puts data['current_value']
#  puts data['at']
#  puts "------"
#end

