#!/usr/bin/env ruby

require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
require 'awesome_print'

shelf_id = "5"

#uri = URI("https://agent.electricimp.com:443/WENqSu+U3q0X")
out = `curl -s https://agent.electricimp.com:443/WENqSu+U3q0X`
puts out

uri_out = URI.parse("http://refillist.illuminatus.org:3000/push/rfid/#{shelf_id}")
resp_out = Net::HTTP.post_form( uri_out, "json" => out.to_s )
#real_res['datastreams'].each do |data|
#  puts "------"
#  puts data['id']
#  puts data['current_value']
#  puts data['at']
#  puts "------"
#end

