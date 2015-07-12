#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'awesome_print'
require 'json/ext'

uri = URI.parse('http://192.168.4.1/relay')

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
request.basic_auth 'olimex', 'olimex'
response = http.request(request)
json_response =  JSON.parse response.body
ap json_response
ap json_response['Data']
puts json_response.to_json


post_request = Net::HTTP::Post.new(uri.request_uri)
post_request.body = '{"Relay" : 0}'
post_request.basic_auth 'olimex', 'olimex'
post_request['content-type'] = 'text/plain'
ap post_request
ap post_request.body
response = http.request(post_request)
json_response = JSON.parse response.body
ap json_response.to_json

